Return-Path: <linux-iio+bounces-4523-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D39178B2E46
	for <lists+linux-iio@lfdr.de>; Fri, 26 Apr 2024 03:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83408283F48
	for <lists+linux-iio@lfdr.de>; Fri, 26 Apr 2024 01:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA75184F;
	Fri, 26 Apr 2024 01:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="Uy/nJbI7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3144EEBB
	for <linux-iio@vger.kernel.org>; Fri, 26 Apr 2024 01:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714094630; cv=none; b=IjE4hauIa+XIwKKnPzGRXOx4QWolEa9dqBILjRSNHlNPT5dKunsYVGWmU6IZcdSTKBhlNuiAnpdmb8/7VULcwW0sb6B2DqbcGWmN8x9QvWWXMB4PI5gZODsgtqAhRjUOzg8oCz9GU4qngWXkphUk2hcShH/b4HPdgzdgptX2wfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714094630; c=relaxed/simple;
	bh=WN3Wx90GnarGBbvwYvBfiRSjvHRTvvewa5iQY3wlfa8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LZe7NHagaDGBqIWwfoJ/jIiawipFPKXP+OaFZb+W4DXcncTFu/AfTKwaPd/J4NhklmjZMD0mLy5K71LnoCcftccGNRbhwjS0gGKb1AiTKut287/76pd7DzrQJc3s810T6lHxMAKXBZGjBzt4p6hECVxVMGu+4HgOpurIpRTwZWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=Uy/nJbI7; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso1365674a12.3
        for <linux-iio@vger.kernel.org>; Thu, 25 Apr 2024 18:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1714094626; x=1714699426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UdDRTiTBbDsfZNIom41LCBVXtQhaZjQmzcw18UpcVL8=;
        b=Uy/nJbI7ZtE0sZIeb5bA8b4cvh2MHgdQLTscKzPNPdFyUS1ym92NrTcU+5H8YOcMcO
         yHVXj4SoQ59fgQuqL5+ZiBsmbmvpnfJjO1r8fMP5bgINNI5rlFrNwznyyPg/D5EDu0vV
         2kBw6s39PuzRqA2iN8Z8WoboyGpJ+ZSMJ6DgHlRoOW3OE17uKX/KslMW/Ak47M/rUaIh
         LNX0DntE7DURMcJAaYtxkdMMHQk4EICx2w6CwRzQkKwiyeVd0eVdyRvVS8s9Wh5pdfib
         tbowHgNukgNlT5E3wmA8SwzWrW3/k0ct+tDXl7XnL2CmFbQqARuw2hroqr7yfoUs/tpp
         ZASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714094626; x=1714699426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UdDRTiTBbDsfZNIom41LCBVXtQhaZjQmzcw18UpcVL8=;
        b=OKgouP+hfjeJgEln16s+f88A3vqkgThErtDl84uYKVfptFFNeJK5NWtOwJc+5itrHX
         M1bE48WdhOpQGpNfG7atP3finbVKs7mKxJ4jnKX9/QBd+MUb72my66+u7xU9yZm3WZ4L
         SX253Hkp7s+VxvEb9JL2LclmUCvDDYt36LagdRbrKriNqsHLL2AaLMQH7xCr7OaNLzpU
         P28wnvyyqxJKeXsrwcrCPhOBPmtRkGg7hTndqGR/XsGwbKMMndJD+Ux7vrXEIoIPvQf5
         OQkFNWoNm2txMa1npSCdmB3ZyL4so+EbBCWQFQyGaEZnNf7YCOEezCDES2dwvdWYO8r2
         HdzA==
X-Forwarded-Encrypted: i=1; AJvYcCUcStFkxJ9nDKknd716k7GsXlEkOkgCmCsSpTUdK2lu+sdLf167Taa3D/XZIlS4Whoowe/iVQo+vIE5aQy0//ysXG+c3rZ+yUuZ
X-Gm-Message-State: AOJu0YwQyyUkwjOYZkm1oYHt7iiW4Kx7iM6LPZTHTi3tF6SRAl2fEpBw
	6vHMgONBM/tzp9NUzuQu/m/ut9gpwdqkdHuQ8jfoi78kwevd/k8sFcS6rOk2ruc=
X-Google-Smtp-Source: AGHT+IEVipMCe3/6V2ZK76e8PB1EWM91qLS8PoOs/Qa9lEfL+86k7qHDW5/mcZROHJ3ek+UBpy0ESw==
X-Received: by 2002:a17:90a:4a08:b0:2ae:f53b:113a with SMTP id e8-20020a17090a4a0800b002aef53b113amr1315122pjh.35.1714094626465;
        Thu, 25 Apr 2024 18:23:46 -0700 (PDT)
Received: from ASUSLaptop-X513EAN.. ([2804:14c:81:903a:9968:e871:2529:9bcd])
        by smtp.gmail.com with ESMTPSA id p8-20020a17090a930800b002a513cc466esm15294305pjo.45.2024.04.25.18.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 18:23:45 -0700 (PDT)
From: Gustavo <ogustavo@usp.br>
X-Google-Original-From: Gustavo <gustavenrique01@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: Gustavo <gustavenrique01@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] iio: adc: ad799x: Fix warning generated by checkpatch
Date: Thu, 25 Apr 2024 22:23:10 -0300
Message-Id: <20240426012313.2295067-1-gustavenrique01@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean code of iio:adc:ad799x to avoid warning messages. These include proper variable declaration 'unsigned' to 'unsigned int', add blank line and use of octal permission instead of symbolic.

Gustavo (3):
  iio: adc: ad799x: change 'unsigned' to 'unsigned int' declaration
  iio: adc: ad799x.c: add blank line to avoid warning messages
  iio: adc: ad799x: Prefer to use octal permission instead of symbolic

 drivers/iio/adc/ad799x.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.34.1


