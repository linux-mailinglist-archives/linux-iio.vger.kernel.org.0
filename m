Return-Path: <linux-iio+bounces-25209-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A638BEAF21
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 19:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2B77C12C8
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 16:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4FF2DF714;
	Fri, 17 Oct 2025 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MGg/QERm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1B92C11C5
	for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719383; cv=none; b=fZxZDjekWBeJMMrg2rJ7aZtIcQD2HluUX4rIWn+LfWnMtRevBO6xtbMl9b5wDo9pOIN9U6qinQIp4uX5Z1hH+0Ftqo+tWMnGcQfmAq0/urzwJwLXEuKiiG85snfHWsdFxfoPz+VRUxhD/hT0pFaxmpGoufXSg+d+oTNVQv4Tyq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719383; c=relaxed/simple;
	bh=qydNSCeSQ+E2GOjHdtY78InKMYtkzGBtuz7sO0dEZ9I=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SKG8LH7aKFiys3KXNNQnis7/KKJB2dE7ro+YTqQ0PqVCqPAEEVUS3NOA0KIUXgtEfd8Johrg9ZLRzIO5MWgZ32XkJsY7GbGdkFG5BIqPGaLPCQnTrtn8CFMgwCCjpbsRhy2HQog1uQhPvGalJib3w8ipeUa5wv5BPTNFWxKbg0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MGg/QERm; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b5c18993b73so365148966b.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 09:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760719380; x=1761324180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kjdz0rl5dcQU1vd/+CLrzz2F5z3RZpHi5RbDUNAW3S8=;
        b=MGg/QERmv2PF2p0psuS2vdcJ6iF3FPKJiXN7Eg7dvw/K88Nih1dkak4mtftN0v+5d/
         qOZEythEsIJh2bSkrL3Ax+4/dme3qarUlAmeK6HyAPdFuebtdA84wtqsoqGHKTo80UDq
         Vk+ydTUMwb9pjjPiMPXzdliZ+Ag8F+iW2afgYGO9BKTfLKEugFvkCKqwV78fzdrM5PGm
         CxZRCv2Ojw1iZ56LHEoiqkSb31LUc7FZ0ibOq3vHN8Sh+9Lp2Cl47D7Jqa5XneR7xqgF
         BhRJPPA3xPQOtrvfUqMcF3x4TzVPw7xruTduTPJ+RN1g0sicBxgOSpavg9Epzk6uQ/LF
         co7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760719380; x=1761324180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kjdz0rl5dcQU1vd/+CLrzz2F5z3RZpHi5RbDUNAW3S8=;
        b=xNdAwUPd3FSHYf2VVXlJw/Cb2nYesEUxmxVVIroO8iDlYYhOS3tYIw/PyuMNGQySkZ
         KoMM7WFUn1VXB5PZeB6lccazmQgclxWu1weEqIAui5024XqC4jYxw+U00VGsV1+7dK3k
         WJ1TdXM/mBgaAWwi+b6evYd1l68jbPqLAKRaUsR3AAXqQGUwDOPaOGW/6pqFewAtE8im
         dgEg5nS6Mheqlvsdic2wXiOqgIHAA3VP/47G1LAQTf8fCj9+kL0L91sBjgKl/YXEe1rQ
         o1So7Dj2IQVgt0wkOaQBHClTtW97sSMe/zSS9omPtaDpp8mBaJNK90oQJRhiAPFm0wgT
         TUbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7uqAWstAktg4hMTa4bL6bB4O4MBRObIQGA6J/sYEWp0ujD9kVk1lIKEzyk4yPpryOnZ7zkW60gPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YypJHQ7eUr+Q+ZTBEi0KC1FThhc2YWu7kE9DtZjpeUzHyiO/tiN
	isqDIZiI+wZzpKTuVvGEL3WQY1mrLoFUtpIkJ374gLjdBH2FnCasBiIZMaG89c3BNsU=
X-Gm-Gg: ASbGncsZ3tNotDJCygawJ0hvOr+gMM/c7+G6/eo4i5c3Zx8fGXHLWMcEbslnVx9HYN7
	v2yrlF2uNM1LvBO0fq+oKf82nMywbOBiVl3JHy4D9QHxaFb6uiSsI1pAhJrqBRFA1lAKfO88yGL
	bNooEh7fFxiW1FtOcdaMrL3IQMdOAB9/+lkAy+IJXt35+neAq1yjxguuTY7Z/0FAtx7usgccV+F
	5mPH8xdLWNptZ60IQoHflpAY4pCTHFhTXfkxJytWrWU3bAcpAMbiQrsjfPRPx/RuGHt5BvYOFQC
	LM39abMuBAFsXRGsaQzOFIL1LoKuuXpjeYJZ9RSjElUEqYKFwzViNf0FrOAA7F7TPgJoNl18bl9
	bh8BCHVs/bm0JADPRBTuZqk0YteYprrdBlqYR27m+dQxb1IbHODWkcrdgjvvxLTeNmHt+FXkhv+
	7NXXSqIK8hVEdqk5WyU9Xgiq0c7w==
X-Google-Smtp-Source: AGHT+IHXqefH327sMsO9RX5OelhEq9jJaKmV2JPysRJpgJrDsL478SviiAp8QmNSVRFVf+//woDFpg==
X-Received: by 2002:a17:907:72d3:b0:b3b:4e6:46e6 with SMTP id a640c23a62f3a-b6472c6191dmr468392466b.1.1760719379781;
        Fri, 17 Oct 2025 09:42:59 -0700 (PDT)
Received: from localhost (mob-176-247-36-41.net.vodafone.it. [176.247.36.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4949998csm122158a12.38.2025.10.17.09.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:42:59 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] iio: imu: st_lsm6dsx: Fix measurement unit for odr struct member
Date: Fri, 17 Oct 2025 18:42:54 +0200
Message-Id: <20251017164255.1251060-2-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251017164255.1251060-1-flavra@baylibre.com>
References: <20251017164255.1251060-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1061; i=flavra@baylibre.com; h=from:subject; bh=qydNSCeSQ+E2GOjHdtY78InKMYtkzGBtuz7sO0dEZ9I=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBo8nH+ESF9IxfWckt3q+TUtO1/qrjD/S281k3pT uSxV0F68iqJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaPJx/gAKCRDt8TtzzpQ2 X4n1DACXgY5C3cCEjzrMv9fEF/HyhzozhvaLM0G9cIDvj4nRNGRHlvbMXo+Zw+m366YGNxBPg+K FkRAFj/NwyGpAwkML/i+Ao1WFmQ6USjzMdSub/Xkq386RIBQz3T5Zuo6GELTmGc0YQM541wHLYP Ram2OPPWGWDLPdrt2mxt6JHAN7HXFOUMOeNnHNZVNUs0aiHsbBfovfUz/h3bPMnJ5qqYc3PPcG6 vU3cpqmzeTNVwl06CKk6ETwYCR3QjoBHiu1a+eI7sJ9zsi0yWJ3wzt4pZSDDQWQ/V3dGzyrHzN1 I/Sgs5oJRQw3jgfPajdZNzzLI2b4UrzmAvWetEa8Ah1eRUZZ1gC7S4q6Uaf+C5pJ9RMZdQuMmyJ uGyd4reZ2lzHokcQGr/p6bJqZipoLvxjrAKnp5S/jNg8/oc0oyCiylSjujSEWRlIro+SqNnGmv1 QIOvzq0Sej3Wc7Ugx0w4lddeBj1RcRry5UsvdqJ6R2putQTzvscGK9DGG8NB94GadGm7U=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The `odr` field in struct st_lsm6dsx_sensor contains a data rate
value expressed in mHz, not in Hz.

Fixes: f8710f0357bc3 ("iio: imu: st_lsm6dsx: express odr in mHZ")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index c225b246c8a5..bd366c6e282a 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -365,7 +365,7 @@ enum st_lsm6dsx_fifo_mode {
  * @id: Sensor identifier.
  * @hw: Pointer to instance of struct st_lsm6dsx_hw.
  * @gain: Configured sensor sensitivity.
- * @odr: Output data rate of the sensor [Hz].
+ * @odr: Output data rate of the sensor [mHz].
  * @samples_to_discard: Number of samples to discard for filters settling time.
  * @watermark: Sensor watermark level.
  * @decimator: Sensor decimation factor.
-- 
2.39.5


