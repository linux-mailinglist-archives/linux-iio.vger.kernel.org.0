Return-Path: <linux-iio+bounces-23799-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD7AB461E9
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 20:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06FB0A4138D
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 18:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0AC31C57A;
	Fri,  5 Sep 2025 18:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="v9jorCiC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0A731C572
	for <linux-iio@vger.kernel.org>; Fri,  5 Sep 2025 18:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757095969; cv=none; b=PU6HumFG2loNZ6U1730Jh4v1Z3rYxSmv7tBhyAu0nvp6WNIV/HKzfquiko2RgBmsnOPcy37dTCiRYuBhFFD/5g+BawCRhnZIH0Ncl4rMxEZGTCLnvNKYeL0eRVxG0FCw8ljkvf6/hkf+VRGP9YYqsf5g5AmQ2z6VG05tYeNdUAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757095969; c=relaxed/simple;
	bh=8Xz0jDmXgFfZmGsZzujrdevuB+dP2gKFc/ViqMkwSBM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Tt1Y5GB2xEV21b0TiiLEGdblP31bNfsZpK8JSwpCZ1DNN7ftyvZKwq7F260KKtgexVBvbRhARJot3BTwfaW/wJJfpWrHPaE/9oMIuRrdG+k8c996ACAezIRmp4LNYL/HRl8zfYAhpQ7erXbdU7vpuRPgR/nAZmx31NWWms+puII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=v9jorCiC; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-30cce892b7dso1031589fac.1
        for <linux-iio@vger.kernel.org>; Fri, 05 Sep 2025 11:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757095965; x=1757700765; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2hjnZ92wkXGB+M9U4sBlOBLi5ruvnazck0COy1mDnAY=;
        b=v9jorCiCnEHH6FW9Pon5aH/LSEgO2Z2T9dJlbzFjGAs59lyHdiUs1AKYqDxKwtqQCo
         tdTPkIOuq0Tq113xeoQW1ruDudJ2r4TQL6wSBx8VkPz4um02Jfpte/VJwb5XPAX0ZkBf
         rBeJWg2ibF/mNBSsCFvw6g/gyw7tcnL/msFCpA61i1T3tDPGswrhNZmV44q/CI0S6igz
         H1TCjKxOmv3PmLm8i9k2UdQBL9iwrq/kEsl8B6yJxeorX1ZK7cRNr91P1ckoyTDDugqF
         rlyeS/h/Hgov3owqDsQtyG6uk3WfMvrhPt+FTaxTcvvQQYY151uZBuwM4Z04zi+861iy
         M3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757095965; x=1757700765;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2hjnZ92wkXGB+M9U4sBlOBLi5ruvnazck0COy1mDnAY=;
        b=NJLZTip5rRiTCKXG+hSCBtuv1nN4pziJ1T9uX8SgNDbJjLy1yc5Y75KiCXQojQu47y
         Ps9GPWgxP2ygu7jDrNcI1XMw4b0MCPAT8mvXBgBd3oZY9cAkup1myrfj7DFvbhBIbagS
         MFos+jy1msaaf5DXyYqVK+QeisuMIk8RuPqStr3LEj36oefeXQLYUtRYFDGDyhAE4Dor
         8jjDdT2ClixzQuCMDqr7ZiSbbiOZUi1RRAU6h0oOtbHK4eoMh6+td+dtWTCMKde8ytTv
         zuNKXexvnCSHa+XHySlYxsWdRQJhHYTuFxFobAwCBqL/d2MXj4WycnA41PtSDoXPNYGN
         WR4A==
X-Gm-Message-State: AOJu0YwMje85Cz8tBkgXE6s1MCrkswWL2vVtYTxEOBqw0RjAiPHEM7MR
	g9X748+yRczOCJzMI1rJXWT4bP7DTaRlY1bezzQC0Elfobdd58nE5TkgqJcjVqJfMF4=
X-Gm-Gg: ASbGncvKteEVJ6su72gkU2f8R+iH5SFDMk6UbRs34XpoIzRhcc1LEAXmhzNbZZ57IiT
	9Dx/P4dLoAjl2VaHJygnIZ+paKxA7dGM1+7s+lnAbS9/xYCiMfIu23tgewR7LTc6zCbJerbTlNk
	NkFkVgFNzqPvyCpGyKkNyQdstvCr8lVk3z5ec83uxRLMTX+6S/T1WAPykAl+hhKFBpICuTR/yd+
	Aj+ESHp4S5OsKsB2fcBhn/voTn1XVrloD9tha+bh8N5N8pACZ8vRI/WxDr5HBHpsCCu+K842bk3
	ATcWF7UOXLIZpui8pQMqIF6lKF0sRO62YomNCNlC8N7lEzK0Ckdxnb5nUQzumzuhZGigam9GOlQ
	1ZRqfrvkF1MaW1wSMzItTBlX73NU=
X-Google-Smtp-Source: AGHT+IGHV5aSKy1+WEZwvDJjVkimaepc+JPc/mUPv20bZpQa4SUghBoJ74xi+wAqFEpb0W0MNDXBEg==
X-Received: by 2002:a05:6871:70b:b0:31d:8c33:59b4 with SMTP id 586e51a60fabf-31d8c342342mr2674795fac.28.1757095965282;
        Fri, 05 Sep 2025 11:12:45 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:52e:cda3:16cc:72bb])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-31d686398e1sm3052292fac.13.2025.09.05.11.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 11:12:44 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/6] iio: adc: ad7124: add filter support
Date: Fri, 05 Sep 2025 13:11:55 -0500
Message-Id: <20250905-iio-adc-ad7124-add-filter-support-v1-0-aee3834be6a9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOsnu2gC/2WOwY7CMAxEf6XKGW+T0FLRE/+x4pCmDlhqmhKna
 BHi3zHluAdrPJY8b56KMROy6qunyngnpjSLMbtK+aubLwg0ildW21Z3tgWiBG70Mp2xjcgIgaa
 CGXhdlpQLjMYfsd2HQzO0SnKWjIH+Nsbv+esz3lZBle9RRWR2G6qvNtBR/wNJBLCLCwR5hpAyx
 HUqBJ+WM05w34OBTtsQtGnQH8xpcI+Jhow/PsVPj8ExguyRSl9JJ64zxiQdakHVooXmizq/Xm+
 jO98BFQEAAA==
X-Change-ID: 20250725-iio-adc-ad7124-add-filter-support-d1c9e53f64b5
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1638; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=8Xz0jDmXgFfZmGsZzujrdevuB+dP2gKFc/ViqMkwSBM=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBouyfuSGFJbQrLF3TgXsnwRzTxuPJG28ERgq2xM
 8Blp2tq7BiJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaLsn7gAKCRDCzCAB/wGP
 wJ2hB/0ZiafirPR4koj+Sk9aifQcfWkSsSlHR5abc4HfTLVDKhK4+OXTUmN/qInmoqBh7ogBqaK
 4iEBH5gSfBdYOIP8D25DZalLAGtLTSqdxW650Vsyix6cap15IqT8UteNpyGc3IjamuDrTbrBrgA
 DF4qErFm3OwkvL/f98U5MyvItku9j5fEtFUt1Q9x5UNpvscdIGSgsRuE1U5sIAN6hfBeJDu4yrt
 97F+wgBA98U+wl52P4UvLFlExRMfIpmH/AvYGr/ObRGpcTiNPjMuu/q8YEDlBIV4n9d18GAhmLS
 M40kbSUxJk4z5hPEr3Vkg0dlX/lASdagaFrA15VvEH0TgIJC
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

The AD7124 family of chips supports a number of different filter modes.
This series eventually gets around to adding support for selecting the
filter mode at runtime after first doing some cleanups to the existing
code.

The first 3 patches are just updating things to use newer APIs.

The 4th patch is addressing a shortcoming in the driver where the
sampling_frequency attributes were being limited to an integer value.

The 5th patch is the one that finally adds support for filter_type
and filter_type_available attributes.

And the last patch documents one new filter_type that was used that we
haven't seen before.

This applies on top of "[PATCH v3] iio: adc: ad7124: fix sample rate for
multi-channel use"

---
David Lechner (6):
      iio: adc: ad7124: use clamp()
      iio: adc: ad7124: use read_avail() for scale_available
      iio: adc: ad7124: use guard(mutex) to simplify return paths
      iio: adc: ad7124: support fractional sampling_frequency
      iio: adc: ad7124: add filter support
      iio: ABI: document "sinc4+rej60" filter_type

 Documentation/ABI/testing/sysfs-bus-iio |   1 +
 drivers/iio/adc/ad7124.c                | 380 +++++++++++++++++++++++++-------
 2 files changed, 297 insertions(+), 84 deletions(-)
---
base-commit: d1487b0b78720b86ec2a2ac7acc683ec90627e5b
change-id: 20250725-iio-adc-ad7124-add-filter-support-d1c9e53f64b5
prerequisite-message-id: 20250905-iio-adc-ad7124-fix-samp-freq-for-multi-channel-v3-1-702ff014ec61@baylibre.com
prerequisite-patch-id: b70de00c7ae218fa6c1e6aca34fb4210922f6d86

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


