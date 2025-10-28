Return-Path: <linux-iio+bounces-25603-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E829C170FD
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 22:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 975311A22B04
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 21:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784952DF143;
	Tue, 28 Oct 2025 21:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVCZt5Nz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3602DECC6
	for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 21:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761687265; cv=none; b=KPxB4fsArEWVjjAlbZ4iWD3dSCuLhnFoBWYwtLbkP1WfAcg/UsKM159khtq7wMsInDO5xaMPPGuTUSU9bauJM4VLlcHRaYa/kz/RSzVtvN3xQEIc0Lv3LmL45cwd2PJhtwCr4nw15nQMVI/4lGPu//gwsgcZiZ9nUPuPaP2CSDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761687265; c=relaxed/simple;
	bh=XSoBT935MeJNZXpYqhnHPZODSP6OKb6SjpmCd7CrNbY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VVXuhNJkCOGOKENMYL1vNvuayoOyYSDyAhd2VHLd9s8juQG5ZuZYfJmsbj+jd52dolMmXHLGmUASdYGUXngjM6plFmR6juCjtc8dXMsjK7Zhk4+nXYF+hN4qNSRgiKsyT8DlVWrqqcRkIa7rvIVC06YouXcUxi46/9oqONdfoPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVCZt5Nz; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b626a4cd9d6so1342708366b.3
        for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 14:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761687262; x=1762292062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GRMPPaG2+hLfbr+lXXCnX/ORmYimK9MpoVFVvxUKG+Q=;
        b=NVCZt5NzdzrB245TN4B5FlbKyFwDb2NDPa2FhqG2wdxL1F3n+mkAwqTU2BucsMEsNx
         eTbltAaaXTE5eXjQeCDlO9FeAp8+Emk8lfCW7KzIV7r5P/DVY9Y2QhdVTJon7FK6ZYOV
         n0KxjNDajhtWeToCSeSUgEdUzI2MnI/vS3Ob4XdKJ8X69pPtM3KQKJ4ckKSFkTosl3O8
         J8k4+dy6ck7bzcQNO3rv/QlaAWkugU7+KYL2tiSKc9721BhCSxrROBCRJbyDl/edlx1q
         ShgQVczTzwQ5RWNXuTcqNmyyh372DhAoxN+yJmCxhDYanxJWDQgdR5lbBX6EN7nn4wFu
         DXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761687262; x=1762292062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRMPPaG2+hLfbr+lXXCnX/ORmYimK9MpoVFVvxUKG+Q=;
        b=rFU3XDwY5lbHoQOkf4uGZN5PrPHU8ZU4u9mUHrknhIwrylagf4unmKZjG8wlAioWnb
         QdbFvh55l9K+xs17frkQFXrM/1MFTuTNEReVtK8s10H67FRHfJYaMzAJN9jxrBwugKle
         bk4ogzOiSbyQiIQNXk84bpteaYG9xmM5rDUZ/RtgQnVOl1I/wJqxzVc0UAjxc/I0knpZ
         2aolqmV5kaUZ8F+I3jfKoPHUhUGgAV64dzRcMGAXkel3NjaODgggc5HfvfgPwWqNIHqj
         9DwrHj0Ar+9L4id6D+wK503av5zHk9nHCML2DjRKCFvWkBOx4XuMEtpLPz2w+8Ma73pW
         bwhQ==
X-Gm-Message-State: AOJu0YzlAUy79UgvyTE1LY9oOWWMJIjgB7NxK0jRuUz6l+4JGQ7w9+mx
	6ewX1ZrG6lkw5fkLtiVuZfQRIWD1ZVVADQf7OeuJAeRSFyZ4/KGDoVkS
X-Gm-Gg: ASbGnctR7KbnATEmcTnQPqRecyW30ms0upc3kc5JH0FZnah4CrH6J5Ou8gc9bSV7Sk2
	DNl4fm6ZnvW5uxTTvCte0sgdBxX1t7Ulq03XSpo4a7WHlIs82i0i+FMya6pC5/Pm/TTnF2x8VOu
	NqLOep3yWPosWPOCHc0E5I4NEs4XcnKGqWki86FPtQ2Yk4IkoqrdLaRe4zR2YmrNybpqwIrW7DO
	S/Gr+LweIBvwiacVy/Kui+elOtq+ASXrCyn3hRAxqSLed0LHcchu+cDxNbtUPdaBJ2GBrGiqw41
	xz8+U2r5HQ7+wMG31X5RGqXkEQl0WJ0GtWFGEHK6yNKp9h80HPue4PE3d21e7NqOkty8LnPwKZz
	R4Ifx1s+IoJh1Lcra0taLgCh/MBiFEYiyRJL7SkUCjwfRevuT78CjuNo7tX8L60uEx1E7wOvtjy
	8PH4+8QxjQFCtFQ6A=
X-Google-Smtp-Source: AGHT+IFA5KTD3XK2W1v7i6BjNBnGtkR4nOklKEuPf8kgVk5BcQQrml4UCNESneaNwggUppbZsaZoyA==
X-Received: by 2002:a17:906:c150:b0:b6d:825b:828 with SMTP id a640c23a62f3a-b703d2fe70amr50873866b.25.1761687261568;
        Tue, 28 Oct 2025 14:34:21 -0700 (PDT)
Received: from localhost.localdomain ([37.161.59.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6db9b86c80sm451303666b.43.2025.10.28.14.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 14:34:20 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH 0/2] iio: mpl3115: support for events
Date: Tue, 28 Oct 2025 22:33:50 +0100
Message-Id: <20251028213351.77368-1-apokusinski01@gmail.com>
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

Patch 1/2 is a small cleanup, while the events support is added in
patch 2/2.

Kind regards,
Antoni Pokusinski

Antoni Pokusinski (2):
  iio: mpl3115: add ctrl_reg4 to mpl3115_data
  iio: mpl3115: add threshold events support

 drivers/iio/pressure/mpl3115.c | 226 +++++++++++++++++++++++++++++++--
 1 file changed, 216 insertions(+), 10 deletions(-)


base-commit: 1d09cf18cc91d29f650ad9811ed4868d9304d6c7
-- 
2.25.1


