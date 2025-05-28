Return-Path: <linux-iio+bounces-19993-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 599A9AC6D7B
	for <lists+linux-iio@lfdr.de>; Wed, 28 May 2025 18:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBCFD1C00763
	for <lists+linux-iio@lfdr.de>; Wed, 28 May 2025 16:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F3228C86A;
	Wed, 28 May 2025 16:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qSshGpZ6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF7C28B7E4
	for <linux-iio@vger.kernel.org>; Wed, 28 May 2025 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748448325; cv=none; b=cf00vW0BteopPBSf5pU5RkIQ0W4rxmpgYyG+L+12gd4AX73ozzg7y4yrbiph6CgNgqDiHVxx+NvvtXZuhKB9XUf9z/c1CvnEEAx6NciVLaF+p8rSuaVed+KFvZ8U+b4aSylePbLquAL9xxcWGMBJZonaDKJhvK1u7NkNGaFuw+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748448325; c=relaxed/simple;
	bh=DcRREdQ0ZIb5xF00hDHe1rvvAjFzi38y8N1Y5D0c45k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e8ko9y7aRuAkJr8uRULpKXNEMNvu21d3b9nwQ04oTyZauZNHEdKzKjXwsaH+KwBAidQQfE+9QAJ0Ocpgx1ujJUbzUrlIKlUf0da1tAYuFg1o65FXQRO7Vjxu7gQSLtzomdkAZ4//BuQS4n+jwhfXW+EKjmr71Iu9VaL73jgOG3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qSshGpZ6; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e7c5d4709caso4078595276.1
        for <linux-iio@vger.kernel.org>; Wed, 28 May 2025 09:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748448322; x=1749053122; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w6tC/IsairDziVWtXhkaDimMYA0/jNvKbB4X1Lbk06g=;
        b=qSshGpZ6ItWc+JjyMXR2REHAQc/3Pziq99/UpT7Ijf1RBHG0RPIc1TRpPb+A22tglG
         zUD8QdytkIx5O8U+/Vw+wZNYZ63f2fFKmo+3h7AhAhUwkd8fEiSJ0Pm9BICC73TnlwUo
         Bn+xHyXgrUd6egnSBpgo8wyrbR6Xzy6ph0MunleESFgCWgtcquwhJSYu1WK4SaccwP/H
         Fq7xz4hVk7MnYE0ixGsZk+l90k9R8+L/U3n5mlHdRtYRNYahWSXunL1qQaZn0n5RZaiR
         +gnuJx+lq4/mDapjVAGRW3pyzWSCjqitGKdJBzpowDlzoCYBn+ln4rdNiJbabBrmSlXw
         J+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748448322; x=1749053122;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w6tC/IsairDziVWtXhkaDimMYA0/jNvKbB4X1Lbk06g=;
        b=KdVN3LT8UzLBQynEnt6b4uWcRXbvAR5vmNL2FBfoTODChJGiQcm2OX7hXhjpmF9CRy
         K03+qL1uICtndT/EVvqXJ2DphPbeST9iPAjQahksMHHVN5PibBZS3Lzytxhq7HOKC5NH
         BIM8UtyLheX5MR/7cTfsj8d/mQEGqN0T5Eu7Y5ROp7+31nbEmY7Fu2hUzYgw+9YQ2agU
         pQSVZYZyIhLK1ZtJOogIDQ9+LexmFL2YMfxf8z31Bz4kJ5JwCCrI5pAgDki6ak6zyHYw
         wP/tM3MOpZJMTWl+0N2DJXS6xtGD3p47zvIqoe4A7ApeXx1ZVx1PykczYsj7mFPo8feH
         2aNg==
X-Forwarded-Encrypted: i=1; AJvYcCUfRrNSSoWgOpq00IgOEmpbbQlWKxrKfRQ04gXVGq4kEEPUpcqXn9XZvI4saAtUdU4FvbJBOORiPjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs61WlAwcqUL0qoCbthz870DypNKYGig65659jmOxh2cfx26YT
	x7Smg998RpYZM05SGE+69MeT06QD718fToXVgBiL9eMopAhynRkZQlxUyTx30uO1MhHJwGZZ4d7
	qMBQF25yWQIcuVY257Xet69d8W/cDmzWfLESpWh9/kw==
X-Gm-Gg: ASbGncvnxzgt3f2fBbzBjJ77nr5kV0ZoT4RcUFFo8WutHvNau9HNTRbZeS2O7uS6GIP
	BnUCFJJ6JULC/gm6KtfvY0vuXdOrl9k0+kJqG44Xbnx9YBIlpDKPmH5PyR8GvgsuwblzZZJe4Nq
	3Expkn1RmGorOFwLqjOygfET2yU+SSzPSs8Q==
X-Google-Smtp-Source: AGHT+IFnwa31CIcmyHHl56Vao4/q5XtrthfioWrNJoyx+lhgVVPWYbbs9O9qtYqlGYN36k/DfrFLU8QJs8LWaKoEyMQ=
X-Received: by 2002:a05:6902:2203:b0:e7d:b107:d829 with SMTP id
 3f1490d57ef6-e7db107e038mr15334137276.34.1748448322260; Wed, 28 May 2025
 09:05:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526122054.65532-1-claudiu.beznea.uj@bp.renesas.com>
 <20250526122054.65532-2-claudiu.beznea.uj@bp.renesas.com> <hojdkntm3q5a5ywya7n5i4zy24auko4u6zdqm25infhd44nyfx@x2evb6sc2d45>
 <111d2d6c-8ac0-40b9-94c3-02f2f64ef9fe@tuxon.dev>
In-Reply-To: <111d2d6c-8ac0-40b9-94c3-02f2f64ef9fe@tuxon.dev>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 28 May 2025 18:04:45 +0200
X-Gm-Features: AX0GCFuID4VhGiX2apyC0Knv4lDmWLbvgXL8Xh33MSHxiRPOzOEH1v_hZ2IXp8w
Message-ID: <CAPDyKFoQYTNBhtBXY-Ds7E0TohtA6558W1Jf3cLsnXDQC74DSg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PM: domains: Add devres variant for dev_pm_domain_attach()
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, gregkh@linuxfoundation.org, 
	rafael@kernel.org, dakr@kernel.org, len.brown@intel.com, pavel@kernel.org, 
	jic23@kernel.org, daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, bhelgaas@google.com, geert@linux-m68k.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

[...]

> >> +/**
> >> + * devm_pm_domain_attach - devres-enabled version of dev_pm_domain_attach()
> >> + * @dev: Device to attach.
> >> + * @attach_power_on: Use to indicate whether we should power on the device
> >> + *                   when attaching (true indicates the device is powered on
> >> + *                   when attaching).
> >> + * @detach_power_off: Used to indicate whether we should power off the device
> >> + *                    when detaching (true indicates the device is powered off
> >> + *                    when detaching).
> >> + *
> >> + * NOTE: this will also handle calling dev_pm_domain_detach() for
> >> + * you during remove phase.
> >> + *
> >> + * Returns 0 on successfully attached PM domain, or a negative error code in
> >> + * case of a failure.
> >> + */
> >> +int devm_pm_domain_attach(struct device *dev, bool attach_power_on,
> >> +                      bool detach_power_off)
> >
> > Do we have examples where we power on a device and leave it powered on
> > (or do not power on device on attach but power off it on detach)? I
>
> I haven't found one yet.
>
> > believe devm release should strictly mirror the acquisition, so separate
> > flag is not needed.
>
> I was in the middle whether I should do it with 2 flags or only to revert
> the acquisition.
>
> >
> >
> >> +{
> >> +    int ret;
> >> +
> >> +    ret = dev_pm_domain_attach(dev, attach_power_on);
> >> +    if (ret)
> >> +            return ret;
> >> +
> >> +    if (detach_power_off)
> >> +            return devm_add_action_or_reset(dev, devm_pm_domain_detach_off,
> >> +                                            dev);
> >> +
> >> +    return devm_add_action_or_reset(dev, devm_pm_domain_detach_on, dev);
> >
> > Instead of 2 separate cleanup methods maybe define dedicated devres:
> >
> > struct dev_pm_domain_devres {
> >       struct device *dev;
> >       bool power_off;
> > }
> >
> > ?
>
> That was the other option I've thought about but I found the one with 2
> cleanup methods to be simpler. What would you prefer here?
>
> Ulf: could you please let me know what would you prefer here?

As it looks like we agreed to use one cleanup method, the struct
dev_pm_domain_devres seems superfluous to me.

[...]

Kind regards
Uffe

