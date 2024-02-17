Return-Path: <linux-iio+bounces-2692-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BCA858CF1
	for <lists+linux-iio@lfdr.de>; Sat, 17 Feb 2024 03:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8AF51F228E3
	for <lists+linux-iio@lfdr.de>; Sat, 17 Feb 2024 02:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFB01B28D;
	Sat, 17 Feb 2024 02:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1RQiGre"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F3518E25
	for <linux-iio@vger.kernel.org>; Sat, 17 Feb 2024 02:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708135972; cv=none; b=r/mt6yOPs6tZN+1/0RtNBCXtAiNnPnks0KZVqMVTi1LZlipNTRjXZIdjVNbVLhVGd5YEEfr1bF6Qrh4SUHF39lFkUukfyd7TMS+a+pAlqCiYPUPmf1/U3ej2c3lI+aizWduuQMp2sVQMCRqmvZSL/h/qNe/N6IfnlRszDZVcIrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708135972; c=relaxed/simple;
	bh=/vQSN1zsxTRzRzr0H8FmFePkihk2LVhaxrxeztqDDVY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=J5SzQcG7b6QZT2g1iRkWu+X8Ke/ar68NNmq20yeK3egaQPddTWIk0GG9W7e5ZOFVzaLklwdD7fnn03h1gY+BhPxcO9EOJ2tE3g3NrU5rz6tSV5gjTqwhCxlUvkZQnjRVTTWR54DblK4M78lzzBR0igJSDaTYPQGR6Fj6USbRinc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1RQiGre; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-411fc61a0ecso20363075e9.2
        for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 18:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708135968; x=1708740768; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RF+UIhV7AtPN92uBPYFt0o/hmFlHm30KLbmv0GqM3tI=;
        b=D1RQiGreibbqR37Q0btX0IWLB6C7YXJpLiOGfEcFQye7cbS1im0TqOGnaDS0RXp3KN
         myGmsbkIqZDbFad0JyvOavyoEFu+nH9yxcNvlIPIQU7ARXFR+ET6GypnSQAEAaP95CTs
         m15fTKvcWJsTDXoO5lozG0cv5MYS0/JkIRRzhZpRtNM+Qbw7vxzE83FxxW6L5bj002k7
         tSjoMwpxCmfr2z2bMNit4M6cP6yRes7qrp6Lco3r7TVbxJwFY0V5hMwrUy4uC6KDNz3Y
         pTAqO2JKAJsMch4ExwU4YuXR1zNdbLijJ/+hK2JTa9aJysaD0E4asLNJNQldNEBnQ0x1
         hRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708135968; x=1708740768;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RF+UIhV7AtPN92uBPYFt0o/hmFlHm30KLbmv0GqM3tI=;
        b=d17P1xYgOphR3N/oDQCz4Rk9+0g+xSyQazBMrifpNNt99bgg5cjM5VXXxiDHOxkZFe
         890Z36+XRxNv17sUlE0TnmgMPAk+b/LBLVgjEdYjybdqBTzyEcO22ENZAGnabj+YON+T
         nET1Qtwd3WZqUfSz8w3tPrKRPEH5EDfGqDkglJ9oCJ/F7QqDwx0oQYasKfYcz6JiBU/g
         MVD5vTDX26CziiXTMTvrjkDqtdZ7nV5NmEi0W7Wcs/2jZWfPNZz1W8S0VzYfzjp3CywN
         xzdZo64Iw3jyUaNG96kfug7aBxYgiSwrSmNvE+zE3jie8ytQa4BHM0RoWT37W+GvOZt5
         npMA==
X-Gm-Message-State: AOJu0Yw+b+ub66msm5KsP9H1ndHEvKBoG33U53SFBoxGopgDjAGzlAAd
	qwgIZ+4/BCXN0zDS1cYkVw8uq4ubEjL5VJVpNum+egEUHYeUWA/dB7ZTqvC3mc7oxpe9mvucOZX
	gbToqegtH/p42tY0YQAPu9QdssmE4G2Tk2D4=
X-Google-Smtp-Source: AGHT+IFZASAKObIeKatks4OYx5gE1Pvicf6LA/P/yRpFUlaM23ZTadNgxmaoG4BcoB52iYTiNWmFAU5gOEALnj0+vpo=
X-Received: by 2002:a05:600c:a3a4:b0:40f:e60f:438e with SMTP id
 hn36-20020a05600ca3a400b0040fe60f438emr4590405wmb.8.1708135968466; Fri, 16
 Feb 2024 18:12:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jeremy Mattfeld <jmmattfeld@gmail.com>
Date: Fri, 16 Feb 2024 18:12:37 -0800
Message-ID: <CABbzQ=f2mUCeUE5fBz=4A3yivLwZZOMwqt8SVHSUeNtZDEqw-Q@mail.gmail.com>
Subject: multiple iio_devices, one shared GPIO iio_trigger
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I have a hardware design using a TI-AM335x cpu connected over a SPI
bus to 4 AD7779 adc's.  I want to use the DRDY_N signal (I have it
connected to the GPIO on the AM335x) from one of the adc's to generate
an interrupt to trigger reads on all four.  I have seen several places
in the documentation that states that this is possible (common even)
but I have not seen examples of it in the kernel tree.  Most of the
drivers from ADI request an IRQ along with allocating and registering
their own iio_trigger.  When binding multiple instances of the same
iio device driver, the first IRQ request succeeds, while subsequent
requests will return EBUSY.

Is the correct way to accomplish this to define all my SPI slave nodes
in my devicetree with just one having an interrupts and use
conditional logic in the driver to only have that one request the IRQ?
 Another method would be to use the standalone trigger driver (I have
enabled in Kconfig) but I have not been able to find documentation
that shows the devicetree binding for standalone triggers for GPIO
interrupts.

Any guidance would be appreciated.

Thanks,

Jeremy

