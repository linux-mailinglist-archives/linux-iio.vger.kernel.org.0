Return-Path: <linux-iio+bounces-8634-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E49958BC7
	for <lists+linux-iio@lfdr.de>; Tue, 20 Aug 2024 17:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 977CF1F24399
	for <lists+linux-iio@lfdr.de>; Tue, 20 Aug 2024 15:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5BE1A7048;
	Tue, 20 Aug 2024 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BMMLy95M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAFD195B37
	for <linux-iio@vger.kernel.org>; Tue, 20 Aug 2024 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724169537; cv=none; b=gtJmZHcx6sTXfdDz9bFx6trkQBxJWKAufsBmWae2Uvd3URMB2qPlzvUA5Ob0EbJ8z6PI9+YPDqDEykywwWxxdoxcpwL8Ygnwt1xdY+DbvNXT6CeFEiaxEBaiNH5LP9D7SXofLYTP5JHZKiNzxOvP5EQ9UKTjDpHBo15zb+dQmDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724169537; c=relaxed/simple;
	bh=WGhbcSyIIr/fQOdxh9+s+geW6Hei0Wbkpns6twCPCAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cLcZRmA3TaDPOFTGUII7MpEJR1AcYLrhuJwnOzFMeI4XGeeRi68hJKyH3ZDZFyOZ63HtfcOxhH0aDzNfe+aafUvxZduwaYrx/WNVQCVOv7tqxtAZny62gphxyE/VfNRjs8d1pta7h9gYlovXAqTlKz9gZ5eHzgs78onkbcGS8jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BMMLy95M; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3db1bc36bc2so2773102b6e.0
        for <linux-iio@vger.kernel.org>; Tue, 20 Aug 2024 08:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724169535; x=1724774335; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qDlT04LNCgm2mSm4ARTKoN0QbMcB1grVRpO0j/iJMDE=;
        b=BMMLy95M5bEYGtMOHV/WAFw1QuJ9n5cWA0VJs+WPP8WHwRnumLzZdoyFUWr9+CVAsg
         cDNrEb+z1I0PwQcUFrfRaWCJva7ZcbIwZFgEcfBG2bSwQ9M+TGnFVvNSX9thJ9XnNXAt
         vErUtaRBRgmbbnNZziJRwt/WTys9x6csmy569bnN0y68H4fJGAzZh9e7qDIrooztkI9e
         x/dIQ5ferjxZJN7CRdOenygj8MTvTOfHacHTPODQAEk+T4Z5EmM45IgZRD1JX9QEglUv
         Baa3BP1iyjgK9S76AE1SsIejYcUCwcZ2A/hsd1kIP6yMbJiJjaq/pIS6n6ZjWb6ISNK+
         AZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724169535; x=1724774335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDlT04LNCgm2mSm4ARTKoN0QbMcB1grVRpO0j/iJMDE=;
        b=obK/dNEq0DqhQscen/N8YG5J7oqNzKah5eJboPfeglTGF/AqXwtp/v0HoorVCMjCV3
         AK+h23G9N4CgmTUE2Y3a6VWBEQlqLABeFx1xKm60P2z/vvNrQqW1s3O1PX/Dn8NaXasN
         Pq3mY91J+e1iF7F5CxqTNCfz7/9hEIM8oUhy02T1E2Vig0Re0rRR1jcOoRQIyXAQAOUj
         WTLEI0UvxHyWVnISOicTuMCvj2+E6e8X0Ruah5fazS8lmVmkngr4YMSi45DgyqVtzBS5
         mTFKyjj4512eQJyNNvAie9SavDgvAvXChDRdEbSRpQFiuv3SXU0XCl9MAJwG0WUUiiNi
         bBHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW61/HMZPEIUnys2Ym7Go/xEctzb0dzeVFX9rvy6JQWOfid6WMz+tBiWu3p7gLhV91gIgx+qTzNr+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx78kWoW8mG/wbYVQEJ0HDF1a591OM6y2i7H5yV0MrkjJz4+5ZY
	n1gaecYC7o82PV6w4QHaTxlRaF58KCG/Pcv0H/nagRd2hNS3zeWIigDH5P1BhyE=
X-Google-Smtp-Source: AGHT+IHkutffJWZQ/q5tRdDMPF0l50eePnYWl7D4EWVgBKv1fTppJhXqO9viedy+cV6Oir8LahGePQ==
X-Received: by 2002:a05:6808:302a:b0:3db:32c6:a7cb with SMTP id 5614622812f47-3ddb9cbf40dmr1472297b6e.9.1724169534926;
        Tue, 20 Aug 2024 08:58:54 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dd33d5a3efsm2872718b6e.17.2024.08.20.08.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 08:58:54 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 20 Aug 2024 10:58:37 -0500
Subject: [PATCH 3/4] doc: iio: ad4695: update for calibration support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-ad4695-gain-offset-v1-3-c8f6e3b47551@baylibre.com>
References: <20240820-ad4695-gain-offset-v1-0-c8f6e3b47551@baylibre.com>
In-Reply-To: <20240820-ad4695-gain-offset-v1-0-c8f6e3b47551@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Calibration support has been added to the ad4695 driver, so update the
documentation to reflect this.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/iio/ad4695.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/iio/ad4695.rst b/Documentation/iio/ad4695.rst
index 7612596bb6e9..33ed29b7c98a 100644
--- a/Documentation/iio/ad4695.rst
+++ b/Documentation/iio/ad4695.rst
@@ -143,13 +143,18 @@ present, then the external reference voltage is used and the internal buffer is
 disabled. If ``refin-supply`` is present, then the internal buffered reference
 voltage is used.
 
+Gain/offset calibration
+-----------------------
+
+System calibration is supported using the channel gain and offset registers via
+the ``calibscale`` and ``calibbias`` attributes respectively.
+
 Unimplemented features
 ----------------------
 
 - Additional wiring modes
 - Threshold events
 - Oversampling
-- Gain/offset calibration
 - GPIO support
 - CRC support
 

-- 
2.43.0


