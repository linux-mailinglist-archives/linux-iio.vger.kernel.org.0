Return-Path: <linux-iio+bounces-26911-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 207B5CAB902
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 19:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82BEF30169A5
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 18:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B552E3B15;
	Sun,  7 Dec 2025 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smkuaBB4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8135A23EA8E;
	Sun,  7 Dec 2025 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765131994; cv=none; b=KgtjcqryqK4ys9Fpikp8+ujfFXGrr5NPYYd9iryjCQaZ8j9m4lxj/kKIwTCCgL/akmucPk1RujxKAASzcj7xfqp/1GX8zNNEVlWwJxAq2zNZlm/7cQ+RxrugKabOdKGTLtKYQD2OQBuiBj25JzYzt7PZxTGI/faDPp9zU7hx2r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765131994; c=relaxed/simple;
	bh=wNkt8OTOdZRueZgxW7gADk3cJgCw4OX8tyzdylAtDQw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VItoogcXNIKhyS19tD7WGnQxpUq5+KeC1+DSMyyMKOVXPqIBqtHXAuGayepEweAgnShwdhfeusOnvgLQzDlB7KZh8l7eeayxpoSgqSB2tzJAQD+MFx46Yj25DvaUQTdX36tcvihcGfH1lMWJILnfWsfX6u+Jdgx9A2wAEK3sbmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smkuaBB4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CD1C4CEFB;
	Sun,  7 Dec 2025 18:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765131994;
	bh=wNkt8OTOdZRueZgxW7gADk3cJgCw4OX8tyzdylAtDQw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=smkuaBB4OBsLWkTaLAkU03TczAcCyVnfLiIYfKVlgX6k2oxIdHmcxS0r5/G533MPu
	 h2ipXu+SJyrM3HnK/B9Ohf77mmzJye319i0Bi1AiFwWn1wK05lf42e8oXMS/JqLpGp
	 noJDcxDYOsHAOP3Hx9z5WGyVvcJTZocOMLiXKR/u5cvgfj32A7pIrePK2tZxRZVvD0
	 PcbDeeZ7kF9iJPR8zV5mxir5hONRKTEOma5X1iCtWdDBPUfjAqzkxVs3Nd0wC5rMCi
	 bUMs0h7crE4peY84h00D1TYTmqEYg+zUORiMCOJTjAitQ08BS7bX7jUXnefOIVJUAk
	 UjcV5DnNhM7ig==
Date: Sun, 7 Dec 2025 18:26:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com>
Cc: Massimiliano Pellizzer <mpellizzer.dev@gmail.com>,
 "dlechner@baylibre.com" <dlechner@baylibre.com>, "nuno.sa@analog.com"
 <nuno.sa@analog.com>, "andy@kernel.org" <andy@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: smi330: remove redundant assignment in
 smi330_read_avail
Message-ID: <20251207182625.3468423d@jic23-huawei>
In-Reply-To: <DB9PR10MB50208862E82581853CDCCD54CDDEA@DB9PR10MB5020.EURPRD10.PROD.OUTLOOK.COM>
References: <20251125171816.63790-1-mpellizzer.dev@gmail.com>
	<DB9PR10MB50208862E82581853CDCCD54CDDEA@DB9PR10MB5020.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Nov 2025 09:56:23 +0000
"Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com> wrote:

> >Von: Massimiliano Pellizzer <mpellizzer.dev@gmail.com>
> >Gesendet: Dienstag, 25. November 2025 18:18
> >An: jic23@kernel.org; dlechner@baylibre.com; nuno.sa@analog.com;
> >andy@kernel.org; Shen Jianping (ME-SE/EAD2) <Jianping.Shen@de.bosch.com>
> >Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; Massimiliano Pellizzer
> ><mpellizzer.dev@gmail.com>
> >Betreff: [PATCH] iio: imu: smi330: remove redundant assignment in
> >smi330_read_avail
> >
> >In the IIO_CHAN_INFO_OVERSAMPLING_RATIO case, the type parameter is
> >assigned from smi330_average_attr.type and then immediately overwritten with
> >IIO_VAL_INT on the next line.
> >
> >Since smi330_average_attr.type is already initialized to IIO_VAL_INT, the second
> >assignment is redundant. Remove the hardcoded assignment to maintain
> >consistency in the code.  
> 
> Looks good to me. Thank you.
> 
> Reviewed-by: Jianping Shen <Jianping.Shen@de.bosch.com>
I dropped the fixes tag because, as you've clearly laid out in the patch description
it is redundant rather than a bug fix.  Applied to my local tree
for now - I'll rebase that on rc1 once available and push out as the
togreg branch of iio.git.

Thanks,

Jonathan

> 
> >
> >Fixes: 6f3d8de8886d ("iio: imu: smi330: Add driver")
> >Signed-off-by: Massimiliano Pellizzer <mpellizzer.dev@gmail.com>
> >---
> > drivers/iio/imu/smi330/smi330_core.c | 1 -
> > 1 file changed, 1 deletion(-)
> >
> >diff --git a/drivers/iio/imu/smi330/smi330_core.c
> >b/drivers/iio/imu/smi330/smi330_core.c
> >index 7564f12543e0..0cf673b44b62 100644
> >--- a/drivers/iio/imu/smi330/smi330_core.c
> >+++ b/drivers/iio/imu/smi330/smi330_core.c
> >@@ -475,7 +475,6 @@ static int smi330_read_avail(struct iio_dev *indio_dev,
> > 		*vals = smi330_average_attr.vals;
> > 		*length = smi330_average_attr.len;
> > 		*type = smi330_average_attr.type;
> >-		*type = IIO_VAL_INT;
> > 		return IIO_AVAIL_LIST;
> > 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> > 		*vals = smi330_bandwidth_attr.vals;
> >--
> >2.52.0  
> 


