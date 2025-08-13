Return-Path: <linux-iio+bounces-22647-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21866B2449D
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 10:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBC835813E3
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 08:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763632EFD99;
	Wed, 13 Aug 2025 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsYBIe7x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FAA2BE039;
	Wed, 13 Aug 2025 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755074690; cv=none; b=FNOukhCvrOqEOj3ngb8/TXYIQO0jD+sJQzvb1eyoArliBzTM+8SCaGYvS6Kdh3LTBo/xb6L5uLF4cqBdssgStKBraYXKI5r33sAvhL9kH22ZAMHzh6qKopulSlqTVDWI4Hsc9EJeQLPjqnzl539D1yV69rrWDSfjgsdQLYbTS8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755074690; c=relaxed/simple;
	bh=8/EBl2j/gQtNgFz/HCLpcSGDp4zxZoA4vaoh6GEUCRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSFFEvOgedCf0vPe9bpWh8pimc5RKuBKZKE57JlRNeJNeYXoYtdoLcUkiJa2saAtgYyaZaF2m9SyeuZWWcZe9ztebuZqU2BgV/QLoPYSRiY271iAX7bl+chau65HHhuItM2nbFJY/GtVGWMxl7+zXvx/Y5eBhw/WGOFpf0TCI4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsYBIe7x; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61592ff5ebbso10008025a12.3;
        Wed, 13 Aug 2025 01:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755074687; x=1755679487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/EBl2j/gQtNgFz/HCLpcSGDp4zxZoA4vaoh6GEUCRc=;
        b=dsYBIe7xwdO4CjImi54hU5Kcoh92Uhx/OiJBh9+UxlsR9PDiAgzCmpORN0JAhjZOsc
         i7aaRuEtoglrbWyLt5kexrCjaGdrb36tY9HR0pm4GqukCye0HLbuq1s0PA4dsu/7OEm6
         +YEIPjfHKPFB454pV1nuEmLkwOCRqC1v8WgXaNqCJeHoXWc6QZCH/75tYID+eSA7ZHnY
         YmIVJS46PDZF+vtidMZo8yU1YOktew9n36LsRL7i73h+yi8bFsv9UuS++DEPMdV3ph1o
         andcoxR/lc9eXP74tKyA4gbjswh3llI2Sq+lt98AX/hNX3Zo6gBF5WR6nnYLdjOTNAMl
         Y7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755074687; x=1755679487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/EBl2j/gQtNgFz/HCLpcSGDp4zxZoA4vaoh6GEUCRc=;
        b=j4WjAFsIJzQaot7t6f0qaC3fKN/CcEZRN9dXwJS0qNOwQ2WOmM8NRqenu4mYUj9Qy/
         UtAOoFdqKCe6FvJEz4p4YS6tP9kscbSuFUW/WmhvrEUAaJeHXPmN2QHzdpQxSd3WJyjy
         RWPp4k2yU1ky+og+GuGO3m2xlR48ORhqOWFtYpf3nh0Tx9b7OWlDmC/GZ6R5lODtAcOr
         eXcR+mq+Fk1ETN5tceAb+V5THFdhwa1KrlFu/+cil3hXC30FnxBNFTtAo5LIt4UdzO1z
         y2nduSE1M+sqcmygQ5fJ/gd8Uc55UGB9xpNWqiXjWd2D4K79Ja3jT+ralPXP4SX49JCP
         1X0A==
X-Forwarded-Encrypted: i=1; AJvYcCUXNwMCG9rgGOrVQRuMGpAL4lKIp91jgdIrVRKG/lKLqxTYIffWX7g2CzfY1x1a6H8aEBkUiW3yEznM@vger.kernel.org, AJvYcCWD8cLAtfy/Rbat65zfshsyekHZnIHVEQe9P6sOSXd0/VHD/pm6iL3P9JOHKQBRcb4b4iAQZKQ+uR9m@vger.kernel.org, AJvYcCX6LJmNXTx2oujvcszLoIrJTASnUXki+biJ33RC+q7XlBL1mM6wSB/D4nUz9a68jX3cqXP1rLw+KgpYeRW8@vger.kernel.org
X-Gm-Message-State: AOJu0YyPyWLOATTTaCrMDkEleD5MauoE9OnF/JuWs90+LFCFHBQwMn6K
	b8xZf9fYM4htGPc+X+1Bk8991FVh1LDQ3xriLPUF6ZyoKCldfP1Msq/M
X-Gm-Gg: ASbGnctkSFIE0YMyHPWutW+R9uBAgv/qIsPlw4PPpIs+H5NFAX0iPimbsOWL6TidRVn
	EId08U5OzkCMHvSPR2b6pd/eM+zPWTCpU9xNPQ/x3heJuTKTAAQnQc5fCKGJJZCAfhgceabiWWL
	QtGdM9Wn8xCyB6PSPRdOXR1yt5DmMtvSFB7CTssb9CnVtFjGMzImzkvLPL6y3c1pFk/jsCcdD/r
	QOmjEVaeU/CgqSKm9hd2cMSzD2jTa1e+xsGOsh1ZRiJ/wJCOFm2W91JQRI8mj3s5myF4MrTKuw8
	rHJr9uCHPc6qCNqgSUVM+i18M1ZvnzgSGctGkiR6iLngbvLW6pSfbtLY8GgIRi0ooYEqGhRV8eJ
	Fbqtk7BiQPaqGrh/VVA8kiPyryQ==
X-Google-Smtp-Source: AGHT+IF7uMnc5o/irDCqk0i1Wmgov16LZRE6rSY5uPo9FezlPkT0mz0qwPic/4Lxr9OIbiek/KnV4w==
X-Received: by 2002:a05:6402:2546:b0:618:4ab5:e85c with SMTP id 4fb4d7f45d1cf-6186bfed0f0mr1756973a12.34.1755074686568;
        Wed, 13 Aug 2025 01:44:46 -0700 (PDT)
Received: from alper.lan ([185.177.137.147])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6184b807728sm2945572a12.12.2025.08.13.01.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 01:44:45 -0700 (PDT)
From: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
To: krzk@kernel.org
Cc: Michael.Hennerich@analog.com,
	andy@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	krzk+dt@kernel.org,
	lars@metafoo.de,
	liambeguin@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	robh@kernel.org,
	y.alperbilgin@gmail.com
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: ltc2497: add docs for LTC2495
Date: Wed, 13 Aug 2025 10:44:44 +0200
Message-ID: <20250813084444.1842413-1-y.alperbilgin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0ece8b0e-6c20-42ca-a3a6-4c35ee2be07b@kernel.org>
References: <0ece8b0e-6c20-42ca-a3a6-4c35ee2be07b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

Thank you for the review and guidance.

On Tue, Aug 12, 2025 at 07:04:00PM +0200, Krzysztof Kozlowski wrote:
> What are the differences, why it cannot be made compatible with 2497
> (fallback)?

The LTC2495 offers a more advanced feature set compared to the LTC2497,
including:

- Adjustable input gain
- A selectable 50Hz/60Hz lowpass filter to reject line frequency noise
- Selectable speed modes
- An internal temperature sensor

All of these features are configured via a second I2C command byte
(listed in Table 4 of:
https://www.analog.com/media/en/technical-documentation/data-sheets/2495fe.pdf),
which changes the driver's communication protocol compared to the
single-byte commands of the LTC2497.

This patch series begins to support reading the internal temperature
sensor by implementing driver logic for the two-byte I2C command format
and exposing the IIO temperature channel. Therefore, I added a new
binding. Without the support for the temperature sensor and this
different command structure, a simple fallback would be sufficient.

Let me know if you agree with the reasoning to add the binding. If so, I
will update the commit messages in v2 to include this justification and
ensure they follow the imperative mood convention.

Best regards,

Alper

