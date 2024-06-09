Return-Path: <linux-iio+bounces-6113-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB00901812
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 22:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E82A52810DA
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 20:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422514D8AE;
	Sun,  9 Jun 2024 20:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CYdW4E5z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45901EEF9
	for <linux-iio@vger.kernel.org>; Sun,  9 Jun 2024 20:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717963587; cv=none; b=A5Wn+pCldD6y3MBhxmUZr1XnJaYU20UDG656vQjje4QQSoEY6jKxaup7HBpkYg7QgSnvoxmJE7p+NbZNpIAsAIFW17TymbO46J6zIEKCCODNC3sVeDaA4ZiJ7VD4Ql/X4MDSjLEzjhJIIr3zkSo243GKq677uztFGwFCBrmDLkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717963587; c=relaxed/simple;
	bh=Y2g3hBH20Ez6tjr+gS+RmV88OyRJw9ykCZUclisL2Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bc/TF7i7P2cIRNyJArPhIKL7tkd43f0uD/tMzVuYC/23BbkKWqfg8QskczwMf0Mc20O+2q4gw/ah6MwLhTmjQPVwB72CUxwJyk7luQ+KOqmTB1yojW/LRjR5vwlrZ9lfLy3Mn2GuSxbG7zY7cywpGvTCR+KbJGH7IpD2MUaUVhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CYdW4E5z; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5b97a071c92so1911473eaf.1
        for <linux-iio@vger.kernel.org>; Sun, 09 Jun 2024 13:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717963584; x=1718568384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zH1+NlAL7sGBrxSanA/FtA/g7DCFzhSaqjwGlIqeYk=;
        b=CYdW4E5zxWh5IWcXejzYoEslcvehPyPu5TRnvnKy2LuGE6XhQFy2s62bOjtxRoQRoe
         bWkYlHamm1eLwTb/YnXWn9Cb/GOwagOkO+rp7DaEG3l/NfbBCqck6r2T1CvuIIK1oSa7
         nxW9DKzma1i19RDENg3xJngRmnmC6ASxLKrC5/VBEQ3CEgit4RKsyhS8YNgqcJCOzyRQ
         mQiz4f+hX2YtHRotGqhKshiux+yDbXmImxDVZpJR4N1wQ5wGoPv7ctRGLXWu6ujY995a
         Ee+JiecsSNE73od4mPgGCLW43zYJGnKXQdAXgsetCY1G48N9C2ubmc+5Bzbdww3QOlo+
         E5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717963584; x=1718568384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6zH1+NlAL7sGBrxSanA/FtA/g7DCFzhSaqjwGlIqeYk=;
        b=Y2u6xRdRAvZhgs7tpgU8ReLtHaqoRJm0cwv2RVmxE5Q7YMJx6QZ7UGzyDYYq7S28yr
         pRVNRgizAkKpN24TI8JJ9zfNIi/Sf5s/xObEAwuPnG2u6d2dzlhvnKlZkxp6ojWFL5c+
         YgTb0po4mfenpp+M5LU0b/Lz6NvvNFw3Uipx34ZEQjpN+tAmjPiLCm07b/hSuZGq/VZt
         ouKcLbxJDeKUfWB5aw3y2b7gb5nY3u+a14AcTCc5tUAXFKlQ01hhw+VC/ayz12VFSwLu
         A/OX7ysCdhuld2cC/QGnP97I7KDAudbrU8JMsL6Z8xkDcTNsqiHCk9vMq4PI9bG6Oqug
         3olQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/s6EqH9doq5L3XpMJcFv/n+BXqkVBM+wEVoZ9kiDNOx3NBxSDv+2UFSDDRxgJ8a5zJfkScpssT1diml6r7IPijkpevBUOHez+
X-Gm-Message-State: AOJu0YxWzAW1iPotGgKiN2n5Hq1Y0O5iAw5tssHpq/+Z3GzIo3JXBrPB
	N4EG//GjqgFs54EPXKfE7LIQZyr0LVPmzT45MzoJZP4YhyTmQe9sZ7lpOc1a4Og=
X-Google-Smtp-Source: AGHT+IEXyblMhCU92LHpLi9n5C30rLt+Oo3AAw9gr5DqMdj5QvfaoFkMH+K9Ls0kXQ5UXrqpIjKi2Q==
X-Received: by 2002:a05:6820:1691:b0:5b9:f2f4:6a95 with SMTP id 006d021491bc7-5baae76ba19mr7502787eaf.5.1717963583757;
        Sun, 09 Jun 2024 13:06:23 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba977e121bsm1413278eaf.28.2024.06.09.13.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 13:06:23 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: William Breathitt Gray <wbg@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Judith Mendez <jm@ti.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] counter: ti-eqep: remove unused struct member
Date: Sun,  9 Jun 2024 15:06:15 -0500
Message-ID: <20240609-ti-eqep-cleanup-v1-1-9d67939c763a@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240609-ti-eqep-cleanup-v1-0-9d67939c763a@baylibre.com>
References: <20240609-ti-eqep-cleanup-v1-0-9d67939c763a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Since commit 8817c2d03a85 ("counter: ti-eqep: Convert to counter_priv()
wrapper") the counter field in struct ti_eqep_cnt is not used anymore.
Remove it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/counter/ti-eqep.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index 072b11fd6b32..30c35b6c6050 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -82,7 +82,6 @@ enum ti_eqep_count_func {
 };
 
 struct ti_eqep_cnt {
-	struct counter_device counter;
 	struct regmap *regmap32;
 	struct regmap *regmap16;
 };

-- 
2.45.2


