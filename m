Return-Path: <linux-iio+bounces-16442-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A06AA53ED9
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 01:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD36516F231
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 00:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8818636D;
	Thu,  6 Mar 2025 00:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeXRo63I"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058BAB652;
	Thu,  6 Mar 2025 00:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741219591; cv=none; b=RWQUx39vjd7CGf+q3CGUbPEGqN6WlUqXPmaP/zK11hbyPco+GR9VbTXIQgtXIpF1M+N1INdcvavq+kTuMc+tusZNsPjPR00wafZa4zygNUkrJMJVSGUEBVkzgLb1g+EZeCls4A1A1gtUE/LwoLBD6n1DVfuCOzgzdlnC0GYAzJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741219591; c=relaxed/simple;
	bh=0ZGBEa3nKN9nmtBQzdi4v/JXQ08scUtoe4Ysqoq5BhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WAiQrs5KMYLk+80xt3gPWlC+laIw/biPJUNmcmkuZIuk4toyMhJQBGdmGygJLOh/r/X534ejvVgx6beoAiHz0JewWeoGUqm3MXy5KXgyn0Vm7ywu30h1+ZBeCGbiUbnJkbgbc4ycNWmMKVn5q5fkH9n1Jw+cMQGpwMStO9lgt2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeXRo63I; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2234daaf269so731995ad.3;
        Wed, 05 Mar 2025 16:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741219589; x=1741824389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZGBEa3nKN9nmtBQzdi4v/JXQ08scUtoe4Ysqoq5BhA=;
        b=NeXRo63In5O7yZewZNh5GLobykzMpsjexIipOxHmqxnZx2g2ARClxsQEtfrsIJW9a+
         S0cJANZowJYuQpb0bWqohlLb5noZt+Q2iFqu3fk2Qxy4nfhU787zP3MmyHwqmxaziCau
         f0vd44f5V2ZbXLD7KuFiXUkHeyQK7HMUZxgR3uSjlMI87LVahSheqxliGiIJparqZgBZ
         2vs4g80awTFONfVZCnVq08nBqyrdCmJ/nqYKbTMjQ8j+M7zFdNjs7KKKsYxcUPOLKqrx
         sVm2zNu2UcVixQN/xynRNvrNfwVeXuRofY3OYxKZxTxW7IxrQv27BLn3Oa4KE8LVPHsW
         bxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741219589; x=1741824389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ZGBEa3nKN9nmtBQzdi4v/JXQ08scUtoe4Ysqoq5BhA=;
        b=aUs2Kyy6o3zKRHccLZRP0/BKjLATVtwsJ5aMk1N1HoH1M4kND42jUdG9U5ueNdONAU
         mj4efv+iYBKC331Qr/17ijMm3EqPFrhWWKvfy8lruTuTxCgfQiuBD3h0I2dx1sxZb6Ev
         1sKJb7xovhtPb9i9WkC5+/fVIfEsBrIRwBk1I/5dOPlMwLcujz+hxmz446t9BmDa5ISY
         ZjEPA8bMQKJ3Oczo45h/nVzfHPl2kKyB85Yty0UQMsvhk38IZ6v7etvRN/qWB0Lbe4NE
         wmR3/bmbEbwpUkILZjYNRAG1FhiO1BZVgncKs6F8Wuhs2uxw4mp/rXvZd2OonVcDUJBy
         Vy2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQOsBribnAfvQDhRcEcxZ0D8S6Hf6YhtcO//V8UF7qauNI8bIR40BZPnGaBuE3YmZEuOPUl2deg8g=@vger.kernel.org, AJvYcCVMxH1FRbbh3ebOdUF7OlCHww8we9P9w1tFPMz0sCOElJUfFG47+Y8h6iy3Phkzr6MX3UcBH3kUiQxN+AoQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwDkscwUrdCkf4KqBh+reVDzTQufoWkuzse03IjdjfxdEPTHKVZ
	7O+aC7M3MfcJsUUIra8MI6k4LbzQzZAZmdYm6aHLTGtfuD26iO8erMW7RA==
X-Gm-Gg: ASbGncuf4ng1MiPyIk/tSoWyesQCocQfMHR7q8bZRe5TdcsAn+TLygqeF7KEDlj5awU
	GTuUr6nsd4XO63AcAUvtPbbvK4xSmKLRL8z1MPzI2p/YK082HePXX1E15VmGzG/Wi8UbsJeb0eB
	tf9wFqB6JXpO+nfvznkzEyGHtpdyjRxllpyXF7feXjzCTuHZdlPolbwIWUnHG1OwvzGoL3z9af8
	LTwLuHWpgaesBB+ktHg0AUx8NT3GZOKq0pQJQ0x2G9w+JihKsCohOjrw2gu8ml6y/R2vcXCXVn1
	gFhQHWixesAkYjmuzPMZo36mfSb4kIeGC+zC5kemjVlU5CgoikvyZMRhfMLyWzLr544=
X-Google-Smtp-Source: AGHT+IHBhYIgc9aRlGjnY714QzC5qHd23J5//vzpB9xP76OCN0p8RlrjfCAV2hn3Yb5KESvtp5ZSdg==
X-Received: by 2002:a17:902:da87:b0:21f:c67:a68a with SMTP id d9443c01a7336-223f1ca5a6emr69095285ad.31.1741219589198;
        Wed, 05 Mar 2025 16:06:29 -0800 (PST)
Received: from danascape.tail34aafc.ts.net ([2402:e280:218d:2e5:857:3077:7768:d8a9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698514ee4sm27463b3a.135.2025.03.05.16.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 16:06:28 -0800 (PST)
From: Saalim Quadri <danascape@gmail.com>
To: danascape@gmail.com
Cc: Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: iio: adis16203: Remove unneeded spi_set_drvdata()
Date: Thu,  6 Mar 2025 05:36:24 +0530
Message-Id: <20250306000624.1554112-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305234949.1548646-1-danascape@gmail.com>
References: <20250305234949.1548646-1-danascape@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorry, I forgot to add a V2 description

V1 -> V2: Update commit message description

Sincerely,
Saalim Quadri

