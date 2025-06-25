Return-Path: <linux-iio+bounces-20957-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90526AE84C2
	for <lists+linux-iio@lfdr.de>; Wed, 25 Jun 2025 15:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BF6518918C6
	for <lists+linux-iio@lfdr.de>; Wed, 25 Jun 2025 13:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDD1262FC8;
	Wed, 25 Jun 2025 13:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRE0Or1/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E053263F22
	for <linux-iio@vger.kernel.org>; Wed, 25 Jun 2025 13:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750858079; cv=none; b=PwYfG5wDg81pZMqHPkTFHhYupBHpV1UVJbfH/WEa3+YcVy4RFm9toaTFowLRRDbKSuPVMUyUkqXJzCpZ7F9deJTq7rgd0zgynqGwuJXT2PgDuwfmgJOuRfGK981fylJGN26n9wkQKRbqlYFVQr7v0aJsDcsJrse+0H6NXMAc2M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750858079; c=relaxed/simple;
	bh=iZiyrGXuB1+YEUvdSzJFXqhAzKfxcBsiF4u9GyhejzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BdFlza08KlYKL4gOqt6YVkj8CaZC/APirSiLjpSMLRE/bHlkumWhvk1fcQScq84zyz0RQtMrG7VQSxdM6aCB24tp0baSbiHbkk/fUUGw4MaV5hZxMbxEBYhrdPjdPjwLoPz9bsvSsA1B1WV2vQH4YlJg1pAK3vnqef0z0KzkPCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRE0Or1/; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3122368d7c4so1531817a91.1
        for <linux-iio@vger.kernel.org>; Wed, 25 Jun 2025 06:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750858078; x=1751462878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZiyrGXuB1+YEUvdSzJFXqhAzKfxcBsiF4u9GyhejzQ=;
        b=NRE0Or1/9BGneWZ8WV4gDjogJCq0EP17gfA2ORq9s76BxgtbszWrpRPc3YUQcjEqDQ
         r4XxIfPLjcF5MOOl4ewFfQwN9I9QT+e1ijHvba1zKW0bSsqcu5bltSJQYRzfImihU8F7
         ElLQAlxeYbJBvIwChS8ybG3MA0zOi1QErYJISBcXB2X5/V1+fmvW5h2Tf2zjFrNQYwYi
         2vSA1cK9SkzLXVAt2Dk8OOfU91FIoVxtYoI9yMBVcw3LEVWiHwgg0/7DV3Jwr2nQ7CFu
         48EUrOW7GxIhjs1UK9w/7hLuEnfuwieBH1MRMPTt+crwYiV0vlRKR7sZi7GQqGRFRQpj
         42CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750858078; x=1751462878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZiyrGXuB1+YEUvdSzJFXqhAzKfxcBsiF4u9GyhejzQ=;
        b=DZM81G/J9PGilwA+vySfMdgCRn2aIP4tN4xM/P3U48t188mnwtSTDh3L/wjnlLu9B2
         IF93Ea5/5EmE/rBAwZDjynSIViGXTOlUwBp/4HxEqtf3L1l2d+yhX6akAGBE5h55RShs
         lX4MxwYC6E085W/4Y3aiRPyRrUpLYfFxYRWwadoM0huSn88UTwAh+hOFmcqrCXXYFZaz
         jYVYVjtO4fSErJVC5hW4R7Eq2N0jW9ymLaqic0ZwAGXGt9Ad5xqOJgihgWtZIxeijWHS
         MrQEVAWKcVxW1I9jfLwN/HxGvh0g2siloYsJAdWnUgAlOPHysOULyC457tm43lX0vc4/
         3zxA==
X-Forwarded-Encrypted: i=1; AJvYcCWXYuB174d7igMWqlIowr1u/YCVAWnWvU9Lihn5KIkuniAwaqhX2I4v5Fkjy83zfr9dvp/VcejP4jM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSztABUiEXENmdir3dNa0ogoHj30LBjD92UniV4r0bM9kvaEO2
	OEaRklVSuEM2VglkvcH8kDZC2GTn9szViuFi3iqGicCVv3IKv37ZbsDvuyyaWtI9tZQ=
X-Gm-Gg: ASbGncs8SEYBXovwCwGM7x8CFDi+rsSg6Y/R4wztFj8ZonVRWBA/0y6Zo+17/Hykxkn
	Vfs9wsjCq9ZpoCxF7nUDLzaCIzqTeoNFSfBNyXCs20E1BlIwWYWp7Xkur5RKma0BMQnA8ZijO4k
	WHjd+mpTmD7z1Qu6ZysbKMeZ7Si3rwoap6pvrEKJRMUPSwa51y3Xc05aR+T6s6fKnxqApqpBtYz
	eDOt2/M93kKCqgqKiIpDXWrQVEnpeU2ZQLyo/SLj0kxikvEUUJ8S0Zh57P2JAs6t2y/7KnRZ+jB
	6/zlU7RJwXoPSVH4mvk8fnwH3LItm1AEPJED/V3A3Log7NseLMNqIUBLzqc65uY708gI98iLI3x
	AdEITq9IZJA==
X-Google-Smtp-Source: AGHT+IGXjDW5Lk/76OL0bOqeo3bP28jGXGOoVqizNK+Jcnk+3xWy4NvMCTuNHsvcxEi9dXpgy/SAGg==
X-Received: by 2002:a17:90b:51c3:b0:301:9f62:a944 with SMTP id 98e67ed59e1d1-315f26b8549mr5935537a91.33.1750858077498;
        Wed, 25 Jun 2025 06:27:57 -0700 (PDT)
Received: from c-sar-augusto-LOQ-15IRH8.. ([2804:14c:73:90b8:4644:12b1:f06e:93a5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f544050csm1882195a91.42.2025.06.25.06.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 06:27:57 -0700 (PDT)
From: "=?UTF-8?q?C=C3=A9sar=20Bispo?=" <dm.cesaraugusto@gmail.com>
X-Google-Original-From: =?UTF-8?q?C=C3=A9sar=20Bispo?= <cesar.bispo@ime.usp.br>
To: jonathan.cameron@huawei.com
Cc: cesar.bispo@ime.usp.br,
	dm.cesaraugusto@gmail.com,
	gabrielfsouza.araujo@usp.br,
	jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v1] iio: adc: qcom-pm8xxx-xoadc: Use devm_iio_device_register() and dev_err_probe()
Date: Wed, 25 Jun 2025 10:27:27 -0300
Message-ID: <20250625132747.104782-1-cesar.bispo@ime.usp.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625101119.00003c34@huawei.com>
References: <20250625101119.00003c34@huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cesar Bispo <cesar.bispo@ime.usp.br>

Hi Jonathan,

Thanks for your feedback.

Just to clarify, the use of `devm_iio_device_register()` in this patch was based on your previous suggestion [1], so I assumed it would be appropriate in this context.

I now understand there might be a risk of userspace-visible interfaces persisting after the device is powered off, which could lead to race conditions.

Would you recommend dropping the `devm_` conversion for now and only keeping the `dev_err_probe()` change?

I'm happy to send a v2 accordingly.

[1] https://lore.kernel.org/linux-iio/20250607163353.47e83e77@jic23-huawei/

