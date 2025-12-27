Return-Path: <linux-iio+bounces-27391-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AF8CE00F2
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 19:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 971063002078
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 18:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326DD325733;
	Sat, 27 Dec 2025 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaU2t/WC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AF83A1E63
	for <linux-iio@vger.kernel.org>; Sat, 27 Dec 2025 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766859287; cv=none; b=RGYmC+fJPmYinGTJYHhgS9kyBe9Gn2IcdZEAq1FvddcUaavnTWs1TttCjfHsH6sgpIP1wnNeQUF76nzAIfsL7ut7sWvfrJ1JXHbQb6h0kLhhWbXuvAyy6g8CbMKWTja0UhAnbxYbY8sow3DLOtA8eoJUcMiLdmQvHMeD4GuRXS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766859287; c=relaxed/simple;
	bh=jtZl1rksLgH4OhhMZngvkORRQ2UYOOaPcULqCG0VIRU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=ENhS3sD9GzlYJAxMSdguZ0yKAwVpVgBu5dLSqRIyDQTcOFTBWtIPkNLgukMqwc9NZ2udqXtwJ9KHFVl6UL/2NWZ3LzO2p/NC5D8QtohUWX+9NqKd8QRyHPuNGm3lpr+IWiUOnKj8ERGhJu99Ph4yMUgCM6y1o5Zc376eA9ZTFlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LaU2t/WC; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-55b219b2242so4595756e0c.0
        for <linux-iio@vger.kernel.org>; Sat, 27 Dec 2025 10:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766859284; x=1767464084; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ghxu4ot+eFHQNDRPaz+Edo5yrH+9SNDJLR+N7OfHFPo=;
        b=LaU2t/WCiJkYDiyuQ9uoyicv9WNQDGCtWnVniJoDsroxlI/5YbYh5FNa8rhKjP9T+n
         QNXv1yXELuvnJZ2IGnGnkTJ9uU7P/LROUMj+BVYg80P2RAJoEon0xDr3qikrQ7aMCUKv
         FkFkUqiY/TixvTq/E/fch1Dshgm6u38HPfAWxewbbiK756AqYEjsXE82+EZet5GHIlyG
         pSKAzK6w9fHpts/4nB2ywgk03SKSbzPd+aYP9JLjLv+BFlvCj8qSaHfGtuoYw+LOkJke
         k8WmyuPsVFwWB1FnexOcM9zM7nisawYEBQMpaijrXXo3HldLooFJD/7rMpf9H74Z1TVY
         k2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766859284; x=1767464084;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ghxu4ot+eFHQNDRPaz+Edo5yrH+9SNDJLR+N7OfHFPo=;
        b=tCgIH8IqLLCo9+iym/LWFrCXxphNZy2YNPtse6oY+5QfK3LG5ELS/9m9C7/vtr6vIa
         yKYeDE/GNfrWDJVZqcm4XL5UXtD9fFQtnseFJMv7vxMyaty3pxNWtiJJdBG6fw0WoBNz
         Pu29i3t5TkMCjPUzXraEs5dYZ3thYD+vEhWYp0qHJuFNNKyHH25DN1TZjO857gGtJ4vZ
         pdbB+wBglich8U7jlsiUYPqXgkU/xJ/dCnPnVQp2f5dkOgpsaG42GmtoXUqKSyOL8NB7
         Rrgg2MOUczcKWdFOhuNl5Dnnktlvai4wP49Nbl/ED8zT4tQU8yTvZgvLmwF+O/Xs/gx0
         wOVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtjCOIMhTi4auAHasX1O/8tPnAo86fxQboAjN5OUfwUM/+gqdQeVnchzQS3IunLym9xsK+ZeelruE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMWcwUpC7RBz3V4GrKpS0H7KDM0LcKk/Ck4XLV87njD7RsgskO
	xY+X4rhR5nC2cqfs91mg3f4oztSnxRG6EGbza8W2LN9S1MPSEf7W3kuq
X-Gm-Gg: AY/fxX6Zuh207V1fvf5QSF8GdIhkBlaiTTka2i93ZXjz5XTXIVwTdpmJoPW/j+GOS83
	sb4YV1kGTnyppMX2EZuz6iamubcu1mbGFBbKPwwbHxz/9ZvDvS0+Aao+QF2mjlxebqxn7u1TJCl
	pnkuNCadd76R1M0JloAvVYnFl+EgzH1XMU7xxRoQ8t9LRCuUxSqP5VqQ1p4BNf6Y5hwA6wyHx7p
	9aybTr4BOdfq5OiENuCgiRrLcKJpxnPqhI3QQQY6h77qsYIDOZKwd8e+XxVaIOVIfK5I05r/n0x
	wNT4HWzpc2/hjMeW8uXutUXi2zzH4ic6BXS3QNvwZ1opL/krOsGDvK1/j3uZdCAwUWrbNcwXFt4
	/bY0vk6KbA7DQjkIpjc+pboGFcskMBLQt/qk4d8rc8YR8/mxDlkqGcfS90CD9XnOsKT6FnoPPgv
	FbJQ==
X-Google-Smtp-Source: AGHT+IG6QFsM11nSf+wH5akB4IrY1tT7ey0vsWf94Wek3IawljHIPBjEQqvpOIg1Nj26GugIf5w2ww==
X-Received: by 2002:a05:6122:4f9c:b0:55b:7494:383c with SMTP id 71dfb90a1353d-5615b8a7534mr8403453e0c.7.1766859284454;
        Sat, 27 Dec 2025 10:14:44 -0800 (PST)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5615d132a6csm7849496e0c.10.2025.12.27.10.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 10:14:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 27 Dec 2025 13:14:41 -0500
Message-Id: <DF97CCMNGWVP.2JBZR7CQF1FID@gmail.com>
Subject: Re: [PATCH v2 3/7] iio: core: Match iio_device_claim_*() semantics
 and implementation
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "Kurt Borja" <kuurtb@gmail.com>
Cc: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Lars-Peter Clausen"
 <lars@metafoo.de>, "Michael Hennerich" <Michael.Hennerich@analog.com>,
 "Benson Leung" <bleung@chromium.org>, "Antoniu Miclaus"
 <antoniu.miclaus@analog.com>, "Gwendal Grignou" <gwendal@chromium.org>,
 "Shrikant Raskar" <raskar.shree97@gmail.com>, "Per-Daniel Olsson"
 <perdaniel.olsson@axis.com>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Guenter Roeck" <groeck@chromium.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251211-lock-impr-v2-0-6fb47bdaaf24@gmail.com>
 <20251211-lock-impr-v2-3-6fb47bdaaf24@gmail.com>
 <20251227144707.1bebcf27@jic23-huawei>
In-Reply-To: <20251227144707.1bebcf27@jic23-huawei>

On Sat Dec 27, 2025 at 9:47 AM -05, Jonathan Cameron wrote:
> On Thu, 11 Dec 2025 21:45:21 -0500
> Kurt Borja <kuurtb@gmail.com> wrote:
>
>> Implement iio_device_claim_buffer_mode() fully inline with the use of
>> __iio_dev_mode_lock(), which takes care of sparse annotations.
>>=20
>> To completely match iio_device_claim_direct() semantics, we need to
>> also change iio_device_claim_buffer_mode() return semantics to usual
>> true/false conditional lock semantics.
>
> I wasn't rushing to review this set because I want it to sit
> a little longer than a typical series to get more eyes on it.
> Anyhow, long enough for this version at least!
>
> Whilst I find it hard to care strongly about out of tree drivers
> and in place flip of the return logic seems a bit unfair on anyone
> trying to keep those rebased on mainline!
>
> So with that in mind, maybe we need to name it differently even
> if we are getting rid of the old implementation all in one patch.

You're right, I didn't really consider out-of-tree drivers.

>
> Given earlier discussion about this one being rather more tricky
> to name than the claim_direct because claim_buffer sounds like
> we are grabbing the buffer, I'm not sure on the best naming to have
> here. iio_device_claim_buffer_m maybe?  Ugly though and
> these are super rare so maybe this isn't a particularly major
> concern.

Yes, it's a bit ugly, but as I proposed in the cover letter, if we go
for a full API rename, it shouldn't matter for now?

What do you think about that?

I'll go for iio_device_claim_buffer_m() if I can't think of something
better.

>
> Given I think the people maintaining most out of tree drivers
> are Analog Devices maybe this is a question Nuno can answer
> for us?

--=20
 ~ Kurt

