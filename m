Return-Path: <linux-iio+bounces-21550-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 586F1B00ECB
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 00:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F62F16DAF2
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 22:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342192BE63F;
	Thu, 10 Jul 2025 22:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KNsu+QWJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028EC8633F
	for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 22:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187239; cv=none; b=Jh1O371AzizEbnIRpUOyT4zB9097jNzddAixkAT8U1/007/W+ozpLBLy9n79QYuZnQ4hQ4EsZP3+7myTukUKmRpgCAofLSVIO4/MNBPG2jWsMU8TBA4ci9uXfzXQxT1XKKs9f+adlTzyGmhtl8O0RTtYGXK2adXrvWohoOFlchc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187239; c=relaxed/simple;
	bh=7t04OBjwHZ+UTchnoJ/u+hKmQ4x1U/HwdOa1mpsishU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BG2kCpa63+tqkkWse99gFBEiNgL3L8ufLU8CUYmAzFBraFQ9TMcLhFJ4VgJl1AdG4l6bslbxKVydwdM93Vl/oY4fPoO+yEOTrn6vX88pq4JlyszmAX+e1Er1/TFY2Myy6sUT7fwL0xey9ySJmV58zFu4nqG6AIheMxJWjOy6LT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KNsu+QWJ; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-40a8013d961so419887b6e.0
        for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 15:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752187235; x=1752792035; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mMWTlCBkcYJ7/ria9BlXYNln9Cum5MLQPXIqgZhIUDk=;
        b=KNsu+QWJHeA8oTRmCtkjY9AuMF/dL2q8rmwiUNUZaYHN49bzMuucROtPvU2MYrLwcT
         YCINSbPx3oaCr2LHKNuK2nMnhdlW29zXe9xtXrQ0Gqpl7HfAU+KwNIhMydXB38VDj/Z3
         6Erw9Eyi8eFfBLy9+bgGxHqwo2vsy+acHTLYQQDA+aU8B8J+VNr/lVQ9rqBqkCUufMyY
         gTuTGmDYf+S+hTgM3ygPYpOiFo/bIjNkyUuZFzC9Le2t1Tac0ofNkQRK2cVILZeGrVdF
         iCgP1XyGQe1ZSiB7XlSZdzwi5o3tXi0WpA+FngvzQ/7lyxZ62GgfdT3PNLpAittX8whC
         YzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752187235; x=1752792035;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mMWTlCBkcYJ7/ria9BlXYNln9Cum5MLQPXIqgZhIUDk=;
        b=vTIQ3gzypgL2bNIayP7h9vwFWAYNmygbSyV8PS1L2H/BTSOVd2ca2xdDSyhoK8vZ6O
         9NtnClHnsJl9bsoSGSrly9oRDSmhfqyPwcEcQMphVfZj4x2nN9fJFLEpaTBP5mDKJCfA
         P3PpjrGHaxN1f0XVDss73U1+RzRooED830sNxBzsAWw9I0pPEFC0438RDQSUDKjBUrQj
         gqpPMOwzECEYFg06dN2Tb5q1gIgO58WHfi0rXRMsB0uOeRE3/9z5q0C6TM1iwKNM/s/1
         REVhinR7WI7OnyUgQ3BNNXiHMg9nVeTmAWyLbJOZDtL1MdHW3IB6lp+2vVlHb6894FGw
         lnZw==
X-Gm-Message-State: AOJu0Yx2VZePcdnx0KNXj+B22ymPOi1PiZwT+ErW4adiPEvkkyaLfwQd
	M3s2vN3u5fs3lncdxIIvDprcamqOIbfsqHaxfzWperwHYU6bBLrVFdWXHqahYK/iPZk=
X-Gm-Gg: ASbGncvDW2l6AGNy2ejAvHvbV+b9NSd16wVcSY4jGkXMWEKjWmdjC9WsDiKgS1M1Pg0
	nmYq7EL6mFPRr8zzu8muzAjSs7JphysRGQXT/7nkoGvOig3iRP57CrsaRfNOniSsbRU5TuaTsIU
	NrokhT1MoEmtUUPqsqPEAme+mMiLkXNWTMR0l7oyqvrVBuRkfPprB3S5vnqh+XU3gIxZa1txX5T
	AAIlwZy6PxLJwDn27vPy1u3pn89UgBsiWZBxJUuA0vTecRhzA9c8v4N7LVRNaH/LxxGDrtlTJzc
	Bxop+rRKc6HVuba0G1d48rWlpuq6DHw0BYUmIeg+eVEbwD7BeVsKDKvY6hD8GgJ/7l2akV8lRrp
	uC42Lad02iiPA3tmcuxPQaoSKU+cDr7JujY0g
X-Google-Smtp-Source: AGHT+IED1e1R/ISgIGptpuodfAL1KpJEKFMICy/lsOIml+rwfQbZWjvObE8t3FadGwgxvSEf3UWmMQ==
X-Received: by 2002:a05:6808:6f81:b0:402:a5c:906 with SMTP id 5614622812f47-4151210b9cfmr870158b6e.34.1752187234939;
        Thu, 10 Jul 2025 15:40:34 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:891b:7836:c92:869])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-613d9d950f1sm305944eaf.18.2025.07.10.15.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 15:40:34 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/5] iio: adc: ad7137: add filter support
Date: Thu, 10 Jul 2025 17:39:49 -0500
Message-Id: <20250710-iio-adc-ad7137-add-filter-support-v1-0-acffe401c4d2@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADVBcGgC/32RYWvDIBCG/0rw8w7U1CTmr4xSNJ6dkMRMTeko/
 e+7rivtRrcPIifH+zx3nljGFDCzvjqxhIeQQ5ypEC8VG97MvEcIjmomuVS8FRxCiGDcQKcVdUu
 XAx/GggnyuiwxFXDce2O0NH7QjHKWhD4cvxiv22ud8H0lVLk+3kl9deXw+genrYlxhEvbjGOGM
 Ds8go/E/MiDGYPdTdEhbLTd8A1qjXzoD4I9DvF/9LxOuzzGkiHOMMVcCBaWDFZ3UvLGSG5Ff6i
 fJ3aPibX4lr1oJVNonzdxELpD1yinLTd/+ulnfhnLusCaEcYwBdLkRjlpG9O0Hf8r6tdv3aNKm
 PcQXaJFwpKiRdBC6VYSHbubmTVEG+JEuL7ynVfUoaRTLduez593DHYNOAIAAA==
X-Change-ID: 20250710-iio-adc-ad7137-add-filter-support-d0ffaa92afc9
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2182; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=7t04OBjwHZ+UTchnoJ/u+hKmQ4x1U/HwdOa1mpsishU=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBocEE4pp29GETvugTpGEczLA05yJd43bXcsRU0A
 aRkYn+mk+eJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaHBBOAAKCRDCzCAB/wGP
 wK1iB/9DO19zyd0Q9b4el5eMZZWDgtRzeQbWI8sjKLwKkrXE6jjMZlr3MGf+DeA0YOP+wHMKBOt
 Q1hGh9wec21KGQ7GJWeixJKVZp8VB38PB6xib/gtjJvxUsDpR+cX5/2Mvpjg2Cf46ivRzN4Cdto
 5niohcSfJk0Ca6v5D51T9tJZt3q7F20AuUuOdcLx9+MbtANpDVna4sMoYMA1StDLit0BEHHsL8E
 UpRnQZde8AH0PNrjKHRMWazFQRv+C5vBz8HcOvBRyDUeuMNGIO+KSq0i1fHBFH8uF1qrsbcI/BI
 +xtlIGcQCwqhNhUo5qcejlExvhNv5EXkaigk+tTQYJP2R3oq
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Adding yet another feature to the ad7173 driver, this time,
filter support.

There are a couple of leading patches to rename some stuff to minimize
the diff in the main patch where filter support is actually added. And
there is a bonus patch to clean up the ABI docs for filter_type first
before adding the new filter types introduced in this series.

This was tested on the EVAL-AD7173-8ARDZ evaluation board.

This series depends on a bunch of fixes, so we'll have to wait for
those to make it back into iio/testing before we can merge this
series. There is also an outstanding patch to add SPI offload support
to this driver, but that doesn't actually have any merge conflicts
with this series, so they can be applied in any order.

---
David Lechner (5):
      iio: adc: ad7173: rename ad7173_chan_spec_ext_info
      iio: adc: ad7173: rename odr field
      iio: adc: ad7173: support changing filter type
      iio: ABI: alphabetize filter types
      iio: ABI: add filter types for ad7173

 Documentation/ABI/testing/sysfs-bus-iio |  25 ++--
 drivers/iio/adc/ad7173.c                | 204 +++++++++++++++++++++++++++++---
 2 files changed, 205 insertions(+), 24 deletions(-)
---
base-commit: f8f559752d573a051a984adda8d2d1464f92f954
change-id: 20250710-iio-adc-ad7137-add-filter-support-d0ffaa92afc9
prerequisite-change-id: 20250703-iio-adc-ad7173-fix-channels-index-for-syscalib_mode-49b404e99e0c:v1
prerequisite-patch-id: 982dde330c34b57a76a3e48ccfc73ea6977833d1
prerequisite-change-id: 20250703-iio-adc-ad7173-fix-num_slots-on-most-chips-b982206a20b1:v3
prerequisite-patch-id: 350fb675f3e0fe494e0ce4ddf5685d9369ffa11a
prerequisite-change-id: 20250708-iio-adc-ad7313-fix-calibration-channel-198ed65d9b0a:v1
prerequisite-patch-id: b94476eb0399877093321fd5010965d44738c097
prerequisite-change-id: 20250709-iio-adc-ad7173-fix-setup-use-limits-0a5d2b6a6780:v1
prerequisite-patch-id: 8ca40138b61bcf4eac7437b8184276576308536b
prerequisite-change-id: 20250710-iio-adc-ad7173-fix-setting-odr-in-probe-915972070e8a:v1
prerequisite-patch-id: 0f79cb2677f8a249283e239ca9ae9ae1a1eeb365

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


