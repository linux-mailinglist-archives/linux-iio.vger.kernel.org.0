Return-Path: <linux-iio+bounces-8320-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB5A94B0D3
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2024 22:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4DE1F23012
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2024 20:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADC1145B12;
	Wed,  7 Aug 2024 20:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ckl2slCP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CC0364BC
	for <linux-iio@vger.kernel.org>; Wed,  7 Aug 2024 20:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723060940; cv=none; b=cKdQdZ8aUwqIEZo9cPI5DBRrZo20PEDmAhDAyjJ53mdE0yMq/cEseoeLQrzezool3uOstY+uGsTwU8NyABraevA7ACZJyAvX5ohdusefN/xNIyXyEYRB/0qS79y9Inb8n/TpLePd6E2X1+X4CLml2z1tZBsRmQ22z3AMXC7JKQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723060940; c=relaxed/simple;
	bh=JqI/7JY0uwHO8jeHmfDAkuQSCd4muvWmJPLKHs/4J70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DxCGsCH70Z1R9PqPbmYkuJWc2r2wg08hdbIhD03aqs0JnZK1W8Do/QjKMCC7+Dx93DI1szaVVplWUAQ/j5wwEPnMIf7CnuvGWdw61Kpo8LbVFdje3yj9Bk37AlrARk/zbgvb0m2rmYCr+k+3eJfHsepZSD3dnm2HUCFbTgJVt+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ckl2slCP; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-70944d76a04so135636a34.0
        for <linux-iio@vger.kernel.org>; Wed, 07 Aug 2024 13:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723060936; x=1723665736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LsITnJxqyk3GLU8VoWLUSQ1dx7O5PrUBJFkjcQc8Yi0=;
        b=Ckl2slCPnKSgr8UNq8Ph9sqxOeN6LcIvmi7Tp9jhlNe4dANMmudJk0IaChD1LwdvQ7
         CsEjf+RfubYyGNybetFxV/Lm/q4fTBHowZqcqySCKOWAF9r+wb2Ltlx9eAWrlMJ3FOUe
         MgHEYqT0pZ7AwbxDTOrHhaR1XoNjjiYuYp06sLHVmgZhJ57cuV7Zfcg1c2rlEHWC2jJH
         npGrNJ/zHP4u3H4UoeC54TKjISYDqN28+jzFZhllOaJP258MOBl985yhwCyWqU1QugSA
         oww7/QMDKw5/OKVJhjKVPzijvhHQxTqKCE0j3JxG+RMO0hyFPfKuph0GW9jkBADUYQYE
         hOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723060936; x=1723665736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LsITnJxqyk3GLU8VoWLUSQ1dx7O5PrUBJFkjcQc8Yi0=;
        b=ryXkwlJNTkSu/KLVtZX8h0gpnyuaQN1CaN0T+qTHHoIFRG80IZpmI32U1IegZArvk9
         cbdW/lur1usEOmrvEYLzZ4e8WRvJ1BUYUuB6KxPkXjkK+vz1notAb4/lpvxD7AGfjZVW
         0FsqosnHBiyfODu+kO+nCS3N4gb2JPLWRq+O0r4ioNi3g22VgIQiGUkfiKKm2hyfDrsv
         oEt12n1jy5J7Ie3Um/O6NbJ7HYxnwi39ml0W1Fmk5w7w0rLNXQcYYOvOl1y/ZFoGz8L0
         6onELXg1rqdMY+7HM7oxN7aF/++1SFPGRJUo3RahFQkNf3NAsUi0DEQnRGTEvLVSmdTx
         JvLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBy4jJE1K3gRjr5RN2Xm4Yt1qIzL+ZUTDkx6ppV6q6frxNT6Kxzodk2cHdVf/xl8c5vjzQgYdDv+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiH2OvrasQPzv3xEtDKjIjstBJq5ivXqKkqgbMPURtszF6p9Ai
	WYaROz7UZvoOjgq4lIrIa543BoznnpjMIRiWERIXAU+SREv8dASPaiJA8sExzbiIseDLUbdqRVj
	j
X-Google-Smtp-Source: AGHT+IHXba0L9xz2feaAjHZF5HL6FfrLqc1XVJbv+ptCNbxlgacOca0GRhf/jsOysJCJOOgMtHOHpQ==
X-Received: by 2002:a05:6830:2a86:b0:703:6f95:98e9 with SMTP id 46e09a7af769-70b4641c8f2mr1430507a34.10.1723060935925;
        Wed, 07 Aug 2024 13:02:15 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70a31eaf7b6sm4951003a34.24.2024.08.07.13.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 13:02:15 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 0/2] iio: adc: ad4695: implement triggered buffer
Date: Wed,  7 Aug 2024 15:02:09 -0500
Message-ID: <20240807-iio-adc-ad4695-buffered-read-v1-0-bdafc39b2283@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

This is a fairly simple series that adds support for triggered buffers
to the ad4695 driver.

Not directly related to this patch, but as a side discussion about
future possibilities with this chip while we are here...

The advanced sequencer on this chip can repeat the same channel multiple
times which, when combined with the autocycle feature, can be used to
create different effective sampling rates for individual channels.

For example if we set up the sequence [IN1, IN2, IN1, IN3] and the time
between each individual sample in the sequence is the same, then IN1 has
an effective sampling rate of 2x the other channels.

Have there ever been discussions before about implementing something
like this in the IIO subsystem? I didn't see anything that looked like
this already implemented in the kernel.

---
David Lechner (2):
      iio: adc: ad4695: implement triggered buffer
      doc: iio: ad4695: document buffered read

 Documentation/iio/ad4695.rst |  12 ++-
 drivers/iio/adc/ad4695.c     | 233 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 241 insertions(+), 4 deletions(-)
---
base-commit: 7cad163c39cb642ed587d3eeb37a5637ee02740f
change-id: 20240807-iio-adc-ad4695-buffered-read-f49eb511e300

