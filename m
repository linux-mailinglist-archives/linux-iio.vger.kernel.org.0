Return-Path: <linux-iio+bounces-4418-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B59B8AC616
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 09:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0381C21000
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 07:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3844D599;
	Mon, 22 Apr 2024 07:55:21 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40394CE1F
	for <linux-iio@vger.kernel.org>; Mon, 22 Apr 2024 07:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713772521; cv=none; b=Pw2R+Uowe3TYpkiWpwLOlhRL0fa2eGLW5RRjAuPjYy0umAz+eHybW+9ydhyexKhzNKuWzk4ipmmxxQLt7VCUAZyvkGWidnhlrMFf9TIPAahVk3Ws9ofvg4IeCKXaojAlLF3EM4jAIm3MMyt31Y48ReskR/8ztgBKqGq8YAilGxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713772521; c=relaxed/simple;
	bh=cslDD1ruDbcJIP8GwzyL448TuBiM02pWSH16l1d+teo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVlQpzkJcFsjQr08zMp2TEK3AvGIVLGZNw0hP5XgV0usC9rMo2u6HNWPO2jvNUT4V1iQjODQgW0SDsPA8nYLikAOh/JeUiHepeOX7XFAyqU58yBOhCfeeHJ/omh1y7sElq+g0EaFdr87GhF3qWp1vKV8DmnNXbYb3HcmlV0Mr/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-208.elisa-laajakaista.fi [88.113.25.208])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id a8752797-007d-11ef-abf4-005056bdd08f;
	Mon, 22 Apr 2024 10:55:17 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 22 Apr 2024 10:55:16 +0300
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sean Rhodes <sean@starlabs.systems>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/4] iio: accel: Share ACPI ROTM parsing between drivers
 and add it to mxc4005
Message-ID: <ZiYX5JlwS9nGkS2Q@surfacebook.localdomain>
References: <20240417164616.74651-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417164616.74651-1-hdegoede@redhat.com>

Wed, Apr 17, 2024 at 06:46:12PM +0200, Hans de Goede kirjoitti:
> Hi All,
> 
> Here is a patch series to refactor the ACPI ROTM orientation matrix
> handling in kxcjk-1013 + bmc150-accel to share the code instead of
> having 2 copies and then also use the shared implementation in
> the mxc4005 driver since some MXC6655 ACPI firmware nodes also
> include this.
> 
> Note the mxc4005 support is untested, I will ask the report of:

I have briefly looked into this and I like this, except the part of the big
function being in the header. Why? Why can't it be in a C-file?

Note, 3 users justify very well to me that shared code, should be shared in
binary as well. (I.o.w. you may argue that IRL there will be no more than
one of such device connected, but in case of DIY and prototyping it might
still be the use case.)

-- 
With Best Regards,
Andy Shevchenko



