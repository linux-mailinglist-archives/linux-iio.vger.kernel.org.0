Return-Path: <linux-iio+bounces-25726-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D06C243A7
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 10:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03081A21354
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 09:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9BD3328E5;
	Fri, 31 Oct 2025 09:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVZIkwkq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D0E285CA4
	for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 09:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903822; cv=none; b=i2ojqH05GZUCMMRSG/dPNYQMdD4HQJF24nrhyGYl1hfUcjA7IuwDUEmjNRcRr1ftHVctmgDXwV9Avw0GLJEUfYETKkVheKWu0lUOe48o27zpHH4tUOkhmurDcvGMzkVBXVb0OCimETumYbIfVzLJmLz7RLN8WKDMXzecLTKYTjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903822; c=relaxed/simple;
	bh=I97Q83K+ui777S6CfZZAIQ5tDnDPu7JVxWlGPd77Fv4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SNqO7kl63xTw33IGVuyQgrXWDClUAQUwTK/6uRYxbXPzw6CQtpJqdxU2FHWdCJndhmZPSjagAh3lCX+5RyX0DXm7zZr0V4SQ3ocvZ35MGTIIFxiAiS7GSSJYqqplpC0M0khHSydjYF5PR3ktEuO4uBcPWHYL5vd1Uzo6ylP+8z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVZIkwkq; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so16191245e9.0
        for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 02:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761903819; x=1762508619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46fycf9oUnMV3uAv5Ag9QK4r8vV80DypkBg2jH7oK7g=;
        b=JVZIkwkqEUuEakOZ7r98k7878TOuM4gRZPofU0AISPq2L2wpQZ9zQwzSKlnx8XuxgG
         iWFobI1xwrw++fMI8zefpL6bsQSef5q8HsdhstEUAiT4D/2MJo5muJSCBNcjYnED7ddG
         o8kGt2WkX+SGjH9KVCWtdDhaWkOblvAwlwweMPI1RNfncVo8y/wtbpkFol2p7coX8N4c
         //ue6vSR+ahTV+wCMIYOBNHERukAkJZN8fIWXDAc7xgNrOrg/V3lMO8zlFgVZce2AVIX
         ovqYJVFIzDkn9f1JlP90ByPjVb71E64twKlQpH3Lu0v9LrK0wcls7SwwbCeYOp5d6Inx
         N0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761903819; x=1762508619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46fycf9oUnMV3uAv5Ag9QK4r8vV80DypkBg2jH7oK7g=;
        b=KvW3o9AKs0PpyqUPH/KJbMqCqN/O2FMbtlWgCgoJWzNC0Ni6neADkFrJ953Wzp7h29
         IZEs8iB5cCp7sp2uB1AtcEPO5qeaKsON4CKegsSr7mHSYFqhXjt0+LbQtvwIp8cCtbdf
         x9GDsw07/Gh3V00eW71v8c8sukHS9Z239En4H/hgp3Dyh2vhdkHtSykE/MLGJ+6JTnD7
         catqNf7UBfuLA/h0FqfZI6DlWUsS/G+Plk0Ga0Os3scAg2JPq6Da+NSTPrAmbPG0OoR9
         LYjWc70zHTKXeYp9vQ6mPSynDoh1n4AWK9k1TzPN4Tmcw0X6cZ26mfPY5/vjGYIJpeIm
         Bkfg==
X-Forwarded-Encrypted: i=1; AJvYcCUwVFekhvH0bXHf+VY3d7hSrunFtBszSWOLTnBSZMzvR7BPfmFy+s0h0EpMZJoXI3ixM9twZ2KPhhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzePEzwkEpi6xMWEL+eO+C4ZHGd0vJAJSO4OQVWhiHaGOw0sii9
	aInzIq2B4CA0Im8OZdZNaf+/ys5uvPssahuZmB3HXoBZxKPNXE/fEAD0
X-Gm-Gg: ASbGncvZzupUZVXrvZnA+0bJ8YsZK8I7g0qzdurw2o2QK7gc71E7St7squl5EokgFAM
	7Kg1jGo2fJwJPxFEKPWaPxe1RmqxLEOhdK0k0+iXKs+FoZTN3MrEDXQ5r8nZodljf1OPgEMmM8v
	RDJq5PPmZ02tsZPf5AnL5R1B1tbWSTSzPZ/3h2rr4JX/IZTxMAgiCgxgy0Pm9AdZQ8RgeqiJuwn
	3iImbo74gJU0aFrDFOBEVrvnS9dRtEMa1wr7L+4d8JVmmUnOJGtllLvQAoltsGecy1POCCTvKwD
	sqg1WZZg6rRCwInmEZxOSdMv3Y2gcUhzsCg5CCEcmkKdtrMcQXJbExOQV4h2ZMibghkuyQA18XY
	BazhMA/B3uDju2PNSiavhc0OOVqviqocd4ZoZFZ+Fntz5wsL9Bk291Rhsv9kOTjSJm+ww7jZ8Bw
	66MTIOWRO/CgVb5IapHbt10yE2fmZaxJGKHsZ6dJvsTGi0hVYNcHGk
X-Google-Smtp-Source: AGHT+IHaDbljb3p5GxaTSFZSQ3N0tqgTHoD2xo4YCWxWuZhf5YrGI9MsOJJB1kFG+SBESO7q1ZJeig==
X-Received: by 2002:a05:600c:4506:b0:46e:1d8d:cfa2 with SMTP id 5b1f17b1804b1-477308aac93mr23039835e9.20.1761903818671;
        Fri, 31 Oct 2025 02:43:38 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c1142e7dsm2605837f8f.17.2025.10.31.02.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 02:43:38 -0700 (PDT)
Date: Fri, 31 Oct 2025 09:43:36 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jyoti Bhayana
 <jbhayana@google.com>, Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: common: scmi_sensors: Replace const_ilog2()
 with ilog2()
Message-ID: <20251031094336.6f352b4f@pumpkin>
In-Reply-To: <20251031074500.3958667-1-andriy.shevchenko@linux.intel.com>
References: <20251031074500.3958667-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 08:45:00 +0100
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> const_ilog2() was a workaround of some sparse issue, which was
> never appeared in the C functions. Replace it with ilog2().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/common/scmi_sensors/scmi_iio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
> index 39c61c47022a..b40c6d6442e6 100644
> --- a/drivers/iio/common/scmi_sensors/scmi_iio.c
> +++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
> @@ -69,7 +69,7 @@ static int scmi_iio_sensor_update_cb(struct notifier_block *nb,
>  		 *  Converting the timestamp to nanoseconds below.
>  		 */
>  		tstamp_scale = sensor->sensor_info->tstamp_scale +
> -			       const_ilog2(NSEC_PER_SEC) / const_ilog2(10);
> +			       ilog2(NSEC_PER_SEC) / ilog2(10);

Is that just a strange way of writing 9 ?
Mathematically log2(x)/log2(10) is log10(x) - which would be 9.
The code does seem to be 'in luck' though.
NSEC_PER_SEC is 10^9 or 0x3b9aca00, so ilog2(NSEC_PER_SEC) is 29.
ilog2(10) is 3, and 29/3 is 9.

Do the same for 10^10 and you get 11.

	David

>  		if (tstamp_scale < 0) {
>  			do_div(time, int_pow(10, abs(tstamp_scale)));
>  			time_ns = time;


