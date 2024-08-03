Return-Path: <linux-iio+bounces-8177-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB23A94677E
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 07:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195D11C20CDD
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 05:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6FD13B298;
	Sat,  3 Aug 2024 05:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLSKHCTS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018A713B280;
	Sat,  3 Aug 2024 05:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722662259; cv=none; b=j7xK/PlcMKmbgvcBiaIejeZh/bXhlvcaUtZbSjfc5hvGf/0hMXGUxyXfIcvFDGsVfOsoyQQg+aLAketKa+t9Q6+ba+DsI3B+JDG1TOhFEz/4DfhdvxHukaNPkldoVxTt8Jc/kxrAoffF49l+olPnGqitFryL3SYHqNMK54rSjok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722662259; c=relaxed/simple;
	bh=4vaVOtdTNYaI3zHlbzsE4juPypyMKxCIZjiQGjvPQEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kvHfuuO17SI7Irtsl/KUdKFzUAUPcsleNoD+wI+tLhTrg4nbRhlHQ0gTL60po3dnMuNTUgYGeSjWEqzepGBWwgQuolHnRy3xC5g+728pLKSyAmVcMeCDnjxowhpS5m0H09SbGGJ531e8XWivxX3/IyeXtYD/9odq1G8cyFSmURo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLSKHCTS; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52f0277daa5so13744316e87.0;
        Fri, 02 Aug 2024 22:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722662256; x=1723267056; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YjWUAa5I5pjUs6EdYh/ud2/eCLiesyuPdNg1IGIubCU=;
        b=jLSKHCTSFxQ9cf8A0P8TAi89vdhTwnKTEMCx7TzBN9uimehDPEjNlX+bGL5q+NxecG
         rMaY4c909KUf7eF8LursPRntHjKs5od2lAI/96P2+WYDn/nPEmkKaXplwMp1jui1lfH6
         A6VYE9FBET9QrrkuFNtel1czJ1m/PUJ55S1ekT2ePKwdibKk/mEXwC4p0kiGNLV+4f+d
         1CbveLzJkLbTzlp2JVaLpGVOQJ64Cl01nxXlendujiPVl53UjsLOHKzRB/SpOXsQcdzM
         Scq7yPNFRr3DVdEhwte9H4oOrX2/jydpmL8fq2xLArmq1KSDvl/0RRm3muuiPzwKKf0j
         6THg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722662256; x=1723267056;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YjWUAa5I5pjUs6EdYh/ud2/eCLiesyuPdNg1IGIubCU=;
        b=rWTh8oE/Fl3TDqPje5eSEbK4+dw74zhtMFEltqXF7HUAm1LCjJRDVmXfWyC+CQNcnW
         7Vbbuk8k9s2IVGrNHCBndKfUU329aHg7j+Ah/rQb+qeYrgyP2VVkAJ9oBmJArkLqtQZg
         oe1/mQSpThGEmkTnfX5j3OqylcIoXZLCpOfgSPvjtOpkxs0ynVIqrXE/49FHIgRY9Fn8
         LEHNuIx+Z08FWXHg6PZKBkswdNmgJ8voVXnxlf6n0IzMEyWGUb/r4CjjLo0Hz7ui3yob
         ig5UuKXSivnqbtXdOiizaO9+hKXP62ehOZ+51YisBm7B57c/3pJfdJPhNI+uF3+jxBv7
         +LxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiIkvnu9qIQnAia6mUfdZar/zLPJncGBVI0Cr+65lm0vQ6OwQXgdCiZLPEjdOjdIsnUdvH65disCbbUd3pjZ5VaCSAc6QUWQtUvB/R
X-Gm-Message-State: AOJu0YxabY9HM4wggvYbdh0bBsdxr79Jxw/PCak3hThW063MMRZGZqMc
	DlEq+yMijZtM6CRXv0B0lh6A02H1SwOQk/PxWwtPRylvkmB3av5RtSNSDkOCjGdlqp2ueNMXert
	5YFBfwKD5kirrJAMi6cYtU5tTbrk8AJqfOZC26g==
X-Google-Smtp-Source: AGHT+IHwPdzu2wCZsKKxn1pj7cwVb4wu14SbEKhar8tKTfIijrmWu3Ky+u2gi89guukYTzNVX52K4GFeD+CNj2sWPxE=
X-Received: by 2002:a05:6512:ba9:b0:52e:9481:eaa1 with SMTP id
 2adb3069b0e04-530bb37425dmr3523524e87.23.1722662255714; Fri, 02 Aug 2024
 22:17:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729115056.355466-1-abhashkumarjha123@gmail.com>
 <20240729115056.355466-3-abhashkumarjha123@gmail.com> <20240729205329.57390e20@jic23-huawei>
 <CAG=0RqKuhn-WHjMbEqq4bCQOs9ERPKZR_udeCf3noqz+TzULyA@mail.gmail.com> <20240730192139.063b7a85@jic23-huawei>
In-Reply-To: <20240730192139.063b7a85@jic23-huawei>
From: Abhash jha <abhashkumarjha123@gmail.com>
Date: Sat, 3 Aug 2024 10:47:23 +0530
Message-ID: <CAG=0RqKE3pR_t7mU4oVRasu=w=bHRJZHTHh=wTxAC9DwSSdfaA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iio: light: ltr390: Add ALS channel and support
 for gain and resolution
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, anshulusr@gmail.com, lars@metafoo.de, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Expose the scaling as _scale for the light channel and don't expose
> intensity (as it will be the _raw value anyway).
>
> It's rare to see a linear function for intensity to lux transform but
> I think there are one or two others like this.  Mostly the transform
> is nonlinear and involves multiple intensity channels which is why
> we normally have those and IIO_LIGHT.
> Thanks,
>
> Jonathan

Thank you for your comments, I have made the changes and sent a patch v5.
Link of v5 : https://lore.kernel.org/linux-iio/20240731063706.25412-1-abhashkumarjha123@gmail.com/T/#t

Regards,
Abhash

