Return-Path: <linux-iio+bounces-16432-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A26F9A50409
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 16:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06ED172DAB
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 15:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CD2250BEA;
	Wed,  5 Mar 2025 15:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBrtU8dU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC7F205510;
	Wed,  5 Mar 2025 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741190361; cv=none; b=OINRLhR04TpPn90a4/G3Vl5kAFIQ2ns/+edxBC06cqbuugO9yOjRdH1EKUvFnajl1rxQLFMtuCq9H/oDfDkEz6MvYlzJttWTvi62lZeFELB3I/7kczbdF22wTA15P3A4h+ucbwrLjBrDHH56WhTGOedupO2ZMd6K9B880ve2ZCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741190361; c=relaxed/simple;
	bh=mKXMDFy7W/QItIFVlHkupMeSaaEcMfQ0VqQn/kjbiBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gq0B/5auy0AtQpGoA9galyl2vkmKt6BYVmkAHlfEcfenSuUbHvojb9/q1uVFWHHofigxCNVr9QJ/3YRnlVxkF+UNvydhR9zEixazqlnCeesmc9dJ0z0DDiLKErt0FhkFWr9dDSeOOaDC3VW1APYObPZwRHE8NVJHW9OxDxy7yoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBrtU8dU; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2232aead377so139065595ad.0;
        Wed, 05 Mar 2025 07:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741190359; x=1741795159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oiLVkJoOmKKWhZybYIihEffKcwMlU/S4KSLeOk4bur0=;
        b=kBrtU8dU8WY1VCD1jekyfhpELpSptTUQkptVAofEA2976L59SHmtDXcceg6WYbT2K9
         I86AsyF6Bl0T/d4VuFj1pIKWIJGqNwBJLZ5T5JlI+TOWjx90GdkjIFarx0tTaGEVx3jS
         XkV/xYiy2Y2ik3pet2BvcPiPWgGhLUXNEj/1YY+dk1YmzkAvf789jgEcLta2uhBxKgHa
         LjS2wKOtEHctjZrmdUqwqeJnVX0QxmXx9dzGKBbbqLjkA5SFCfdCLnONxp+HaFIaQ8ne
         upIlrOI2gvpA0GOaqwcyK8u4np+li69EWNKVbmDjuo0SOvfAeQHUOWZVXwIzYwRHs+/C
         g7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741190359; x=1741795159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oiLVkJoOmKKWhZybYIihEffKcwMlU/S4KSLeOk4bur0=;
        b=OgXb8dTru7KHeKg1ThItTIl+gaypFLIzUniYFIqtglNOARiS/Gw031IAGVH93vlx/0
         q37vFIrfNGyGpNqsmV5/eBMeJle6wS/Nef43YzJZpsjQcBEGrv0VTbklQYOnmfNvC0WP
         tLIBc70w1euSPsbrb23A4JOQSR2wylBvY1eckH0mNahcnbjjEd2Znu9pTDmsmJP7EUmP
         yITtS2dGyFNrZiSiDKm557JFgLilz1KeMhFg7SvDNwxc+tdivf0CjPkVOONeIlWbHXlU
         msGwVYd0Vr01fDqtQT3P09mvad2Nnim/nRDYimeQMfB703Bjq0zO+8GbbgSVj5m1KpJF
         Vihg==
X-Gm-Message-State: AOJu0Ywi1hw0JB08FXWP8JWtwmLhRKwoxZ47yN0Urc4jybot9+Iw+mgw
	PMV7NDzcJ/lIyNdomlkf9/1ykEJOC2d98nVefuWYim1+r8SGpvGoabV1A40G9RE=
X-Gm-Gg: ASbGncuKG5bZ5hD+qPHT9dFiIhYNfifVCVl2LRuceSCio3hSujLOspNpbb2jPUtw8Xd
	1V5Bsmcis3TSuJu6G7DfBqXr5Or7o7dU+mBRZALZnYck0YwZwtTb6BDqtSIRc72EJ0IdnOxViDC
	YLOSEg/rTqJSYGsIwDjrGuo4zEmPoYapROTgHe8+7Sz0gLT3C4x+Ji2++BHYEoFv+Nd4xgLUgnH
	RKeNWG4M0Hd79NGjnlwepBSfuOCT4orEllw4vY83MMYqnSO+2G+47TJj0f0aumYWLwqGFHku9BT
	glu4kl5mijjVlkrBcqyQ3aMcUpht4lFRpTufknpDNVOANepzSGseBOK46Wa/tpWAHqU=
X-Google-Smtp-Source: AGHT+IE5QI2Fa0yoMUE51s3cn5NK1Suq/GDtTYbEyUTc0cC3esYxqKH57yGIYTktDsZr0iSfMPyYSQ==
X-Received: by 2002:a17:902:ea10:b0:21b:b3c9:38ff with SMTP id d9443c01a7336-223f1cf49f5mr55675635ad.37.1741190359134;
        Wed, 05 Mar 2025 07:59:19 -0800 (PST)
Received: from fedora.am.students.amrita.edu ([175.184.253.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501f9d96sm114914245ad.54.2025.03.05.07.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:59:18 -0800 (PST)
From: Siddharth Menon <simeddon@gmail.com>
To: linux-iio@vger.kernel.org,
	marcelo.schmitt1@gmail.com,
	gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	lars@metafoo.d,
	Siddharth Menon <simeddon@gmail.com>
Subject: [PATCH 0/2] iio: accel: adis16203: cleanup and standardization
Date: Wed,  5 Mar 2025 20:59:10 +0530
Message-ID: <20250305155712.49833-2-simeddon@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series improves the adis16203 driver by using standard unit macros
and removing an unused spi_set_drvdata() call.

Siddharth Menon (2):
  iio: accel: adis16203: Use units.h macros for voltage values
  iio: accel: adis16203: Remove spi_set_drvdata()

 drivers/staging/iio/accel/adis16203.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

-- 
2.48.1


