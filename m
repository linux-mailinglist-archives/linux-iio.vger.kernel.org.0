Return-Path: <linux-iio+bounces-7375-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62169292A2
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 12:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2024D1C20F33
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 10:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25F74EB37;
	Sat,  6 Jul 2024 10:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhaHVvW2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C523FB96;
	Sat,  6 Jul 2024 10:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720263106; cv=none; b=pW00pUkgzwYDT5rqmiSxxDW9KDehrAvhyldx0OHfS6ohc25r79O0XppdGIvnvVgkzX62I6vEboI3fwLUhm01z8CFclBPw9ZYBFhNq6YlbeXX6sflMNqGIcJukTQFdUgycW9Luj8ZgZvrIFJDl1h138goamkO+PyYcmzPJdEceb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720263106; c=relaxed/simple;
	bh=JW57UkYHZcMdBbPWGcNusgNrdeWvIoF2PV77+Uf1PA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bTR24Qzq9DtlXwYgdGT6oXFw7OiNTA0i17I9tbvWjWD2IE53BBcJNV74FXRPnBViYvPA8aBLFzb8w5Lw5K3Ehg1SKQPfXwjZf4e2FoRJDJ0T9xd/HiJztLo1gp9tZfaihHxtS2jhRNCdOMWDcKaxwoD2PJYM/oilQLh5S4mKMYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhaHVvW2; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-58bac81f3f9so3134796a12.2;
        Sat, 06 Jul 2024 03:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720263103; x=1720867903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JW57UkYHZcMdBbPWGcNusgNrdeWvIoF2PV77+Uf1PA0=;
        b=YhaHVvW2K9UWr1D6qLAQMqw4CzvHFygnEnPy2dieqglqeYtPhjk1PkP/plRSaJc6+i
         jSXF9TW6BOxuhgbK5Hte99AjTevJijPYlaKAXHytEj/JlBEY1o66U6R32Z5sbzYDnwk6
         PPUKOx97E5YZbhkBToK9wdZT7fO9XWAB8I+DG6V8vYOL2J82p0MjA0LgEgyzXcIthzGj
         YX5FVJ4BKHAHWdk9tQUa/kQ2PlC3FSRZEFuAAdEHSRu8Yiw1FOISZ0HOraC9i5vL/Pmv
         8WCnCZa4zyWb4a18F7mQ53/as9evMvbskpcmZOjQcwj9fLO5bosMoy1hngpEuhBN3u50
         nZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720263103; x=1720867903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JW57UkYHZcMdBbPWGcNusgNrdeWvIoF2PV77+Uf1PA0=;
        b=Ahu/TKZptWnRvIqIWcdSrShXhYZdr41svnVfo3syEO6Rw+t2/YvYfxrGm5m5esVZYP
         F/ThtysO4CI3zy4kG7C1EOjfTY8uYipx9iT/LRcAtN/xVcMS/rvmBLeyavBBYIWgixto
         Tf3aWDo0H8LSGIU34knG7VnVgU1yBCRKy/grlDqg+Ra8XOnlxuOwpsHpDZLxYwqknymr
         306PmEIauVr/Qh/u3csLEdiU3aILW78HxmzzYm5ZmgMCE+m8AyPjblfGUtZ1rKZuMai3
         uYl+mrak02mT9Z9XABU6dIctK7D1Aimyisn4iiUCLTlufNLo/sN9hBAJGlzFCJ/U5cD8
         bIXg==
X-Forwarded-Encrypted: i=1; AJvYcCX4gY4lBJ91kY09sAMEXFJqnvbrmLhK2EQpgHaKn77HsS7BHSk14rTOdQkP3euULyIpfyKPBSW4Bl4AiR5m2Lm+9sMXKO7tZVlDoNEH/wMSJZE4pCelbyGwWIxmp4zCIg0T51dVbj+M
X-Gm-Message-State: AOJu0Ywmsi2E66fAtrX26Q8XugSGTmHgwZS8cPrtfmVIEMK2GGQksjit
	5K/XiXICJ7UM+rDR9dG67E5YZqOIJaayiFxrtaTuCLh+Yp3bBnYJ
X-Google-Smtp-Source: AGHT+IFNpTayhhTm0HQLbFaEhu4dN9+PM1JK+On5SxcVboOvTl0hazqVwiXSdVxIlM1ISfSjoFxxFw==
X-Received: by 2002:a05:6402:4409:b0:57d:24ce:cbc8 with SMTP id 4fb4d7f45d1cf-58e5c72ffe2mr4950722a12.31.1720263103058;
        Sat, 06 Jul 2024 03:51:43 -0700 (PDT)
Received: from localhost.localdomain (mob-194-230-144-236.cgn.sunrise.net. [194.230.144.236])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58d75e20c30sm3959305a12.43.2024.07.06.03.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 03:51:42 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: javier.carrasco.cruz@gmail.com
Cc: Michael.Hennerich@analog.com,
	cosmin.tanislav@analog.com,
	dan@dlrobertson.com,
	jagathjog1996@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linus.walleij@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com,
	nuno.sa@analog.com,
	vassilisamir@gmail.com
Subject: Re: [PATCH 05/10]: iio: chemical: bme680: Constify struct regmap_bus
Date: Sat,  6 Jul 2024 12:51:37 +0200
Message-Id: <20240706105137.98124-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240703-iio-cont-regmap_bus-v1-5-34754f355b65@gmail.com>
References: <20240703-iio-cont-regmap_bus-v1-5-34754f355b65@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the BME680 part:

Tested-By: Vasileios Amoiridis <vassilisamir@gmail.com>

