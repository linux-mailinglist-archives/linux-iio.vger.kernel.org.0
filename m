Return-Path: <linux-iio+bounces-22795-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C8DB28D4B
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 13:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34B8716211D
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 11:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4CF2BE03F;
	Sat, 16 Aug 2025 11:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxUHE3oJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E622C28D829;
	Sat, 16 Aug 2025 11:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755342664; cv=none; b=HjDy+mLIHRMUUPSTZUONDVQF209o487SwOVyQtULYwpvt8uKldrccwEQE+NygQjLHgIJmtKj/iWFIQyQoVngbjO91CYJQ5nAT6X9WAo5hoa+jppcMqZQYrYVlGRHoHPohLaNW9hUmy5typ0o5nQp3F5aA577aRUQZdwxw49/dKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755342664; c=relaxed/simple;
	bh=5sG0nUC46XMsHcCPG834yBQJvwRc9M5SrRtdf1wONaA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JmtJUIZLYNjFmd+MdWTaNEtWI9SohaJfuhrLSMjq33mkjQXWLDyFA6tnZCiNuTG95pE8XFRH8KBcn/LF9IdYa3U4kYOV2tn6ERxiFowzz59loB9YoU6leHhku80y2/jqBNpCL5uFDuB7t7rNv1S7Ol8f8AMhUREnZ/rj0CQyKag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxUHE3oJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C146BC4CEEF;
	Sat, 16 Aug 2025 11:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755342663;
	bh=5sG0nUC46XMsHcCPG834yBQJvwRc9M5SrRtdf1wONaA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RxUHE3oJKbW/ebRW4Pi0IOSQlP4EhClFjyj5gXqfe2hlYJZxHj8G8+Mit7CQugdpV
	 p98/afsdrNShNM7HsJtLRyeqIFVZq0EID8Wy777FjRMk0zoBpVfRYEbjBmQjMtY5z0
	 wurXghLAyQh77ArgipcTsEAZQik4O5lF4aNaeQXiBT2kmJo+vVMfF3Va0RsFUHSNNF
	 yoHtpO1o0QJSxh8UIW9U2xr0vO/Fw+JijiG7MTEPKyfn9jVeeKSDBUq7ed9DKpKRB8
	 dTd2/mfOLc2B0kLSyG2/sp2PWQZiwqOxAUHOxCv8nQ9AFVTrk8NXD2lMTx5L1aZ8Ew
	 UL5Ba69wXRIZQ==
Date: Sat, 16 Aug 2025 12:10:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Junjie Cao <junjie.cao@intel.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: core: Cast info mask to 'unsigned long *' in
 bit-ops
Message-ID: <20250816121046.38a9fb92@jic23-huawei>
In-Reply-To: <20250815022528.24705-1-junjie.cao@intel.com>
References: <20250815022528.24705-1-junjie.cao@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 10:25:28 +0800
Junjie Cao <junjie.cao@intel.com> wrote:

> for_each_set_bit()/find_*_bit() expect 'const unsigned long *' (see
> include/linux/find.h), but industrialio-core.c passes 'const long *'
> in iio_device_add_info_mask_type{,_avail}(). Sparse flags a signedness
> mismatch.

How do you get that warning?  I'm not seeing it.

> 
> The masks are used purely as bit arrays. Cast them to 'const unsigned
> long *' at the call sites to match the helpers' prototypes, without
> changing memory layout or behavior. Changing the field types would cause
> unnecessary churn across IIO.

Did you have a go?  Superficially feels like we should fix this up and
that it should be almost entirely confined to relatively few core functions
and the types of the various elements of struct iio_dev.

Might just be (builds and I'm not seeing new warning but then I couldn't trigger
the one you saw!)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 159d6c5ca3ce..9125d466118d 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1243,7 +1243,7 @@ static int iio_device_add_channel_label(struct iio_dev *indio_dev,
 static int iio_device_add_info_mask_type(struct iio_dev *indio_dev,
                                         struct iio_chan_spec const *chan,
                                         enum iio_shared_by shared_by,
-                                        const long *infomask)
+                                        const unsigned long *infomask)
 {
        struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
        int i, ret, attrcount = 0;
@@ -1273,7 +1273,7 @@ static int iio_device_add_info_mask_type(struct iio_dev *indio_dev,
 static int iio_device_add_info_mask_type_avail(struct iio_dev *indio_dev,
                                               struct iio_chan_spec const *chan,
                                               enum iio_shared_by shared_by,
-                                              const long *infomask)
+                                              const unsigned long *infomask)
 {
        struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
        int i, ret, attrcount = 0;
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 2f5560646ee4..e45306821e25 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -271,14 +271,14 @@ struct iio_chan_spec {
                        unsigned int num_ext_scan_type;
                };
        };
-       long                    info_mask_separate;
-       long                    info_mask_separate_available;
-       long                    info_mask_shared_by_type;
-       long                    info_mask_shared_by_type_available;
-       long                    info_mask_shared_by_dir;
-       long                    info_mask_shared_by_dir_available;
-       long                    info_mask_shared_by_all;
-       long                    info_mask_shared_by_all_available;
+       unsigned long           info_mask_separate;
+       unsigned long           info_mask_separate_available;
+       unsigned long           info_mask_shared_by_type;
+       unsigned long           info_mask_shared_by_type_available;
+       unsigned long           info_mask_shared_by_dir;
+       unsigned long           info_mask_shared_by_dir_available;
+       unsigned long           info_mask_shared_by_all;
+       unsigned long           info_mask_shared_by_all_available;
        const struct iio_event_spec *event_spec;
        unsigned int            num_event_specs;
        const struct iio_chan_spec_ext_info *ext_info;

I don't think there are problems with how these are set as that is always
BIT()

Jonathan

> 
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> ---
>  drivers/iio/industrialio-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 159d6c5ca3ce..e9491a999ac0 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1248,7 +1248,7 @@ static int iio_device_add_info_mask_type(struct iio_dev *indio_dev,
>  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>  	int i, ret, attrcount = 0;
>  
> -	for_each_set_bit(i, infomask, sizeof(*infomask)*8) {
> +	for_each_set_bit(i, (const unsigned long *)infomask, sizeof(*infomask) * 8) {
>  		if (i >= ARRAY_SIZE(iio_chan_info_postfix))
>  			return -EINVAL;
>  		ret = __iio_add_chan_devattr(iio_chan_info_postfix[i],
> @@ -1279,7 +1279,7 @@ static int iio_device_add_info_mask_type_avail(struct iio_dev *indio_dev,
>  	int i, ret, attrcount = 0;
>  	char *avail_postfix;
>  
> -	for_each_set_bit(i, infomask, sizeof(*infomask) * 8) {
> +	for_each_set_bit(i, (const unsigned long *)infomask, sizeof(*infomask) * 8) {
>  		if (i >= ARRAY_SIZE(iio_chan_info_postfix))
>  			return -EINVAL;
>  		avail_postfix = kasprintf(GFP_KERNEL,


