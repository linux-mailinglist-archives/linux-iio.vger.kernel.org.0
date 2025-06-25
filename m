Return-Path: <linux-iio+bounces-20960-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B75AE8B29
	for <lists+linux-iio@lfdr.de>; Wed, 25 Jun 2025 19:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0604174A73
	for <lists+linux-iio@lfdr.de>; Wed, 25 Jun 2025 17:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264513074AC;
	Wed, 25 Jun 2025 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SC4pTVQY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DACA2877CD;
	Wed, 25 Jun 2025 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750870954; cv=none; b=Yno0TrB5OqVp3PYb98G939eggLw+vC0CblWGRU/xxQagPLfSaQjEiDesvnqF8FTx1S7+pI3Azhhelijostm2AVwOUi6ggy7ptj87cZhQx6+rETKU2Ad5zvWS4V1TYbDJD71I0DUU22jPZN99kpLBQuV1cgIpryktcAVrT65+/TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750870954; c=relaxed/simple;
	bh=khscqqJradz4nhQ0yEyM8taDMs1UnvFJVIztRC52SI0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CkprsFhj7kF0PIDB6+3g/5N+5lh4jgrElxulDqAefSd/9sO8NkGO/0pOssiE5bFqTVP3biKZHm7XlUuAj6KhvDZWQi3rTa2gfiXvEj6sUsPX/taL42IKxpHDRpS6A2dnqhmtwZtnbAspVQS0M+dGXZqZC1t9syf5LpHnbLrwM0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SC4pTVQY; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-adb2bb25124so2471966b.1;
        Wed, 25 Jun 2025 10:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750870951; x=1751475751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LUcw6tqkXAGg4kfEd6zI2DgoXo0mXCRnCqCpiS51750=;
        b=SC4pTVQYWLXl4LJt3oADmh1Y0F3iq3GQn1/hFWYZxU7FjZ/g01OXkc0fs31+gFyNZe
         lY5MaamalvmOjZgVaANZyGhLrQeEpG7jt7hieMbatUfln96CFvMhVvVUByd4gYYjMi7J
         oqNmSGSA20Tc5Zwcmq9CiZQamEcKFW7xXZo2xDTIQItSICGKfxIIWEvg9UmzABHcaOTa
         Q/wYYTKvVO4fArVTE+za1mQngJsGxgp14reU+USEIdNxN+Xu4BZ5X8F4eN+CYIGmSIO4
         BYZ+CPF39uVTu2WOn8+NInzqbAxDNejwyfwqMFgZES09uYTRMOLAgwrqxFmffmERk8lJ
         aBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750870951; x=1751475751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUcw6tqkXAGg4kfEd6zI2DgoXo0mXCRnCqCpiS51750=;
        b=kJcR7FXSqr6XzeKAxgKaCcMcrQA8j03QpDXroBLwW+OFru8okanG6y1dMMxZ9EVVC0
         qVColORzcqeHFxCoqDAKY52KhE4mdDINeo7G7tchzVVpIZ8Ec5yjAVNqJ05hufFxaZ6t
         WMzVM2L+QTogBbyR9b3Rq/zXFeoLWsbvrzKB5lAYhMtVkx6C+CPABrhKu9jfLETkghrP
         TDGVDZcJ0IMjciIYTWoQsI+BClBgwOQFHrb56Na7tac4I/xjb4W0ZHI7qM1tZdATxS8o
         PdBlH9arejC9ADkR77gAigefLQXbGU38RTma7toO0Wr1CoKhC1rL/3SUC5yeHZly6Lug
         o65w==
X-Forwarded-Encrypted: i=1; AJvYcCWCDXzIZ71gR3c09cLvOsUI2ewgG2np0xprtgUxC8t9EM3OsdLfzPkYFcIFiK0Cn+q4ePG83/qxjdxccHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRz76DEoyxq5tDpSxIDJ4xY2FOHe6UUsnuu3xvK79/sXH6cpWf
	fHqdPH18rMBy+kIewwMOr5XAD4tEoSOxufnaJQNeGVNd0uBUkm7B44Qs
X-Gm-Gg: ASbGncu+TonMw3ZPQX0A0U5YkeKjwWSA30EB+VXh77WqCo27p8y5bNLjQ+vghZR1dtO
	rSkMNX7h3eEpML5r5Y0frLbLDthNmhrwH8ZJa3HtHqHByHEAAAHWkXO0SD77Y/rm+V+rf+L0nOT
	BtGZ7zlbbWWqCJyYZctzICVUvsPSN2yhsJiWLFOS9Ase/qgRqvU56mz7v5lqIbuZ3dOtwi3DCk8
	+B1OmlBfFqUc/VvhoFw7hPIwsLyAM8AwT8asQG6F5OcO0ARQdqOKO85pu+bSOYYZ5ohdTnDX/sx
	TJgzLuMNo8gu5zoBT/GmtAJxQxno4CknyGj/n3VmGd1DAqA4eDUDDCEqDGVaHlqBV3iHvkRx9HJ
	xIOKtAPbLokx9zGrzbgOKIvz5jTNRRmQX
X-Google-Smtp-Source: AGHT+IEnJFUloNus4XSLlG5TNZkgdP8zIdePN0zuhU9JG6MGun8pTC9DkBCPxNDgdW/TGZyK/hkMGg==
X-Received: by 2002:a17:906:9c82:b0:ade:902e:7b4b with SMTP id a640c23a62f3a-ae0bec50615mr107921466b.7.1750870949591;
        Wed, 25 Jun 2025 10:02:29 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0cb358618sm69249766b.102.2025.06.25.10.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 10:02:29 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: mazziesaccount@gmail.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	l.rubusch@gmail.com
Subject: [PATCH v1 0/2] iio: adc: ti-adc128s052: add support for TI's ADC121s021
Date: Wed, 25 Jun 2025 17:02:16 +0000
Message-Id: <20250625170218.545654-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Add support for ADC121s021 and related (single channel).

This adds support for the 1-channel variants ADC121s021/051/101.

I'm not certain whether this patch is truly necessary, or if there's a
more general solution for single-channel ADCs that would make this patch
obsolete. If such a solution exists, please let me know. Hence, this is
perhaps more of a question than a formal request to accept the patch.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
Lothar Rubusch (2):
  iio: adc: ti-adc128s052: add support for adc121s021
  iio: adc: ti-adc128s052: replace literal by unit expression

 drivers/iio/adc/ti-adc128s052.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)


base-commit: b57cb7c47e31244bef6612f271c5dc390f761e17
-- 
2.39.5


