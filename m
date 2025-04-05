Return-Path: <linux-iio+bounces-17632-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA80A7C7DB
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 08:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4668D1704A1
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 06:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFE61C3F30;
	Sat,  5 Apr 2025 06:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjlPS6iu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C8C1392;
	Sat,  5 Apr 2025 06:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743834235; cv=none; b=ZPTHL8bWaxRBAxx+/E+R6gX2zMaLQt4xiMm6x70MJVgejXiFxVB79bJjPyJwdsyFvGzgN8WXU1e+IWnax/VTlraRrUUU48WsT4bMN/gjjmV1FSpIsh4eXxF/6USkPMEABNu9hWU3X4u9KYU+suEAucnRZrF88BOpJc8gE9a42c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743834235; c=relaxed/simple;
	bh=H3lMjJstZIxzthUGoR8r9ZIlBsGe1hsGapDGGNpx+1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WMfdCCz6H9S09El83Yh9q0asInZwxAT2IYX3M1iZSThnB1CJJQ92UoxXO4RlyDBWhBz02pO2UD6GY/RREQKE6sYbwnBpvDFoPKp6WlBvcXdNmQMu1+Y3eLDfC4dQBQ19KHtlxYtTWeM2DaQ9xmzU30l2Qj7ByzhgfpNCjZhZW/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjlPS6iu; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-227d6b530d8so24539775ad.3;
        Fri, 04 Apr 2025 23:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743834233; x=1744439033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3lMjJstZIxzthUGoR8r9ZIlBsGe1hsGapDGGNpx+1s=;
        b=JjlPS6iuwYcuHXRk8BG3nUHEFIeMItRQ+eNzIEYIY6qhTyWX4+xmE53J3dSJEXkP0N
         E31l9SLoyPyMiatiuESxMMgilL7O5K7V4/4i85rzSBykaUtxHRGqh2SNh+okMrfb95Sl
         IRQ9b9kEVoewToa4OY8v6LO/2qmBNMxzOpM1VAJlWVgnu9+PluL+4oDPoOVQJHw6EbGk
         VPVg7zZwTte+n+mi1bNfRFrODQTjYv3vfnIxIiZ/OG8TN1x6Oz+Bw5EdbuDHdss8/n/j
         EcjjNafWM+BLs+2DgrJ6tU356OT+FaUwEvQei2d9pO2WC26RTQL43ALU0eSLzZ724Hu/
         QOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743834233; x=1744439033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3lMjJstZIxzthUGoR8r9ZIlBsGe1hsGapDGGNpx+1s=;
        b=aN4foqWAPl5FeSRp+Sy6D1Kg8YKRHMWmaA2uSV/9jIIcZQ0dif5suDjgsvXUDacmQJ
         R8bSVXjg7BJeDZF4rl/UihPmKTW+bmBFkAYpcc1oia5fYrhpSCcjvfy1juUmTWGRQve8
         MR5T12NEyIG546izhB1xYzoQFrlCeYsjxYOC3twJhCW+gn9tW0YUEneCcuXT05aGrJKt
         enYnf58BX5/J2ZNG2zjA6QOHK082SHL+cH7CBvZXdjhTuoBo+LLz1pSECfOHbzGiokkO
         OYmNVgYqvn+IjYMswpG54JSaGYlPuEfbKSx1ROFtyh1jQZTF7P9CWm6EvC3nknfdeg09
         uHAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2jyesTS5WBOwNOu84GNkEl0tigUaJNoBinRdaiFoTzLUL3tnjlljYHQ7y6q1AbEacivOD4vQaU7C/BM8F@vger.kernel.org, AJvYcCX8ujAnKlu91Y26a6mzEhqpKoIFCEFyRfusAuXTzk5mMH+vtvo/HYzI7oJF3Qj8Qy6UsZdeW6GY29Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh2hDjl8MiadTlv2wEttzoG2HaFHgYwT3p5RwsmBBeBmbpxplb
	p1SXt2Q8kFkRADEeIh/HqtkXlHx5c4VuMBNtCKD7qWJkBzuJ4q6c
X-Gm-Gg: ASbGncuqV36IPA7kQFGTLOaFfiuV7mXsMeWf0MT3cC31aTbkAN+BFOFvg5RwEV2IQ6B
	2OFY18Wod3nnEbYM1SXc+srhKNQVCNChJWitj+LjAJKI1MRDLotSqx2rSamxlFLtBPT0aJ6XGWL
	lRVUeYdV7BAMQvRTkyyURiYBDGtmDxx3SUArHjQVTGVH8eWV/I0I/ihOgWUT5lWlaPLv4JoJCc7
	oT3vCb0/oJKgqyNr+P3peY46jc7Hyh6nX2Lpce5KSEXATmXwFN5xI+7QTpO+1Hy3QQjstl60pHP
	xtIMrRl1RsQ4GNfWv2CYQujAnxE2Vfh3eY0+zu6F+Aa76Ht5brNmHMN83mYI9F7R2qh+
X-Google-Smtp-Source: AGHT+IFsNUFu1VL458GDUqiNDTLs8HJioVMW9055o+WQu/szUrWXSNruETi7fQbSK5bhUWhVJz5l4w==
X-Received: by 2002:a17:903:1a6b:b0:223:fb3a:8631 with SMTP id d9443c01a7336-22a8a06b7ebmr91344945ad.24.1743834233452;
        Fri, 04 Apr 2025 23:23:53 -0700 (PDT)
Received: from danascape.tail34aafc.ts.net ([2402:e280:218d:2e5:8608:d339:4e74:f302])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297877275fsm42984665ad.221.2025.04.04.23.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 23:23:53 -0700 (PDT)
From: Saalim Quadri <danascape@gmail.com>
To: jic23@kernel.org
Cc: danascape@gmail.com,
	dragos.bogdan@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt1@gmail.com,
	marcelo.schmitt@analog.com
Subject: Re: GSoC Proposal 2025
Date: Sat,  5 Apr 2025 11:53:48 +0530
Message-Id: <20250405062348.43025-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250309161905.4b029278@jic23-huawei>
References: <20250309161905.4b029278@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you very much for the responses, albeit late, it took me sometime
I was studying about the working on IIO, and the proposed driver on the GSoC page [1]

This is my draft proposal: [2]
I am continuing on the same thread, as you mentioned, to keep it on the public list.
I have enabled comments, to ease up the review on your end, such that you can identify if any issue is present and point it out.

My major doubt in the proposal is regarding the timeline of the project.

I also would like to suggest, if we are able to complete our first driver before the evaluation, then we can discuss working on
a second sensor, if that is alright and if we are able to complete it within the time.

[1]: https://wiki.linuxfoundation.org/gsoc/2025-gsoc-iio-driver
[2]: https://docs.google.com/document/d/18R_ZNWn36mAG9gb2TqepuxBwj-Hck3CrZHFfWUuNmyo/edit?usp=sharing

Thank you very much,

Sincerely,
Saalim Quadri

