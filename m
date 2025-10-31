Return-Path: <linux-iio+bounces-25775-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BF3C26E11
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 21:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8542B189A851
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 20:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF1F326D4A;
	Fri, 31 Oct 2025 20:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTX52QtH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90775277CB0
	for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 20:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761941938; cv=none; b=R++AeT1Nd8S6aATB0jOuZjPKDQSi2FhqLawaAS3nr0dze8WoYgvpK7l6eillbOpi8m6ycJGUT/lHb+o1MYDrYx5Dbu5h3aXXaagapqIgyTQNH4dJZLac2nuUh1xM3JiZl/kHQX3IZ2+PCdxYRo5JusCY+70PQYLa03eXlXCJIEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761941938; c=relaxed/simple;
	bh=EEcao/OdWrXIjMLda+Iv+NRypafBtS9SOmFKm62yuaY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q7EX/gCWZBwLSoL1LQ3CdqVtkyNoqkJ45AnCwQ/tG1pf4fsiz2t1zkKvuvu9yfH4PYnbqyKSMff4/IDBB2QITTWbznMFEk4nQsxSQx5m+HuwKenA8rFmVh5CPsVlfLqqYSwqkTR1QWwiHNoMsoBHcr7OMWRNcdp9/Iap1rj8or8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTX52QtH; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4270a3464bcso1851945f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 13:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761941935; x=1762546735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6dGKudV1APcuHRNBlFTcVX5gOCMz3Arr3oxQu93hExk=;
        b=WTX52QtHqvC+R7r+2gFjP9F+J7bkiHZn7uign0QQUtw0cocX+/3JDSQcDeUnJSQMGU
         CTc6L1xUon+m3O4kLop27HPoLwW5PJvb5C6kqdFiBCbqFNM5uGvoXbxEGwVASt+OMLGP
         RlPdmcPhmSSEcvdc1WJEybMLJr2G4nRNtHigTCEagyC0Hj3iv98gxyeqSbxwphcCqeVJ
         lGLBX1ziHZuCxe6027qRNynXaxkxtdvHqK8T/WKqclEQeW/GCX9tdbMxNhmFhxl+hyiC
         SSj4XLR00dOwRHhsybGS+2zxbsQMPVYBwB/ukMQ+25IpssSKn37rwg/7+YAChQVi5Izu
         AmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761941935; x=1762546735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6dGKudV1APcuHRNBlFTcVX5gOCMz3Arr3oxQu93hExk=;
        b=MU/37FhI16RsVMha6UwjZpI+NjN1nfGzYR4bov1f20wd1YtNclUmJ6q4LlLvuV8nPW
         IXmV+SdgwHxhZeleP2a1ffU427Uzwqihiw/CYSggn393euWAc6/z3jsMhzacARFyW91N
         1gelcz5vSlogd4yeFRsXVhM9SQ1zWfrdYgIL47UdDLlP91lrrqUe25JKlttBYwLSvkTd
         lp2c35N2iZh4ePp4Q6jAWecSCHkUAizA8LUUx81A97ozRgzK5flA0blpahre+v/3btq6
         kAUohtvipAc6Ix0sav9/MZUigZfpqtemu4Z9MzI6uWhcDmUNhBBwHh7XYWe8MvqV+GK2
         3ilQ==
X-Gm-Message-State: AOJu0YzFLK33tt9Hu5E53yVRcKk44J58Ba4aqXpw02YTzXeJ8NcH+h74
	zcaQY2/B50IAmZDOBcOOu+34QuMIz+p2UjhAwCSYKEWa6lz8NGCjCs3Z
X-Gm-Gg: ASbGnctuYg/ky7nbm/kRym8F2ZOkALXea8qxppa6SpUdfI9/avg9W0PCpqMmfi2U1dr
	vJ/qe0WCNeD9qJGy8PhgJHOwGM1tEDDuuGL4UCxRAGzLYiWGFVo2jq6ubHna+aGy3GPCO+gBm2L
	dCFUBsIwFW/sgnHBoTJMVkV5ebw1jGbDAnyT+GNTgPSXmQk0mAImW5xoV7eW1Y2FclGbJn7dlpz
	laSscV762Bz1J8plusQ4yHsyC7cbBExhFQBQXN/qf/GILAkUxmPCxb9V+45YVvkKr6DxNyZ91rz
	cwyu3Zm5yGRMgNKAuMtVl/Qcx+p7UUFp7gb8Ql8ylzBvabWunBssxF5YLjmGgFRJNoopJlx4LWf
	MmPVzAY9cjx+2Kgb/+gtLFbzJ85pR4PuL75lHRCgD/y97W8KyCc5AA9bUwpWhPAaPbKkUuxWVws
	j3wiXQe8dtJicXq87w3XUpvL9+eqXmZ50R5ooS
X-Google-Smtp-Source: AGHT+IE4FKu0ijCN9tQ6rhN9cFZ0bcy6DAWWQE3HV+Zsvla1klttTnrxaVDbk/QOoKKwRhgxcG6EWQ==
X-Received: by 2002:a5d:5d89:0:b0:429:8a71:d57 with SMTP id ffacd0b85a97d-429bd688474mr4422224f8f.27.1761941934577;
        Fri, 31 Oct 2025 13:18:54 -0700 (PDT)
Received: from localhost.localdomain ([78.212.20.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c54efcbasm1800360f8f.8.2025.10.31.13.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 13:18:54 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v2 0/2] iio: mpl3115: support for events
Date: Fri, 31 Oct 2025 21:18:20 +0100
Message-Id: <20251031201821.88374-1-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,
The mpl3115 device can raise interrupts when a pressure or temperature
threshold is crossed, this patchset adds support for them using IIO's
events interface.

The two previous patches were squashed, I also
added a small patch documenting the new pressure-event attributes.

Kind regards,
Antoni Pokusinski

---
Changes since v1:
(general)
* squashed the cleanup patch
* added the patch with the documentation update
(patch 1/2 "add threshold event support")
* patch description: explained changes in locking
* read_event_config: replaced switch with ifs
* read_event_config: return as early as possible, got rid of int_en_mask
* read/write_thresh: pressure: calculation changes to comply with raw ABI
* interrupt_handler: reordered the INT_SRC_* bits in if condition
* read/write_thresh: used sizeof() and values from limits.h
* write_thresh: replaced `u8 tmp[2]` with `__be16 tmp`
* dropped the space between casting `(u8 *) &tmp`


Antoni Pokusinski (2):
  iio: mpl3115: add threshold events support
  iio: ABI: document pressure event attributes

 Documentation/ABI/testing/sysfs-bus-iio |   2 +
 drivers/iio/pressure/mpl3115.c          | 219 ++++++++++++++++++++++--
 2 files changed, 211 insertions(+), 10 deletions(-)


base-commit: 1d09cf18cc91d29f650ad9811ed4868d9304d6c7
-- 
2.25.1


