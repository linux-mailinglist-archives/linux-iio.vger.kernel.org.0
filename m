Return-Path: <linux-iio+bounces-16446-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 942B6A53EFA
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 01:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB17F18933EF
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 00:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456772114;
	Thu,  6 Mar 2025 00:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9699QBa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAD353A7;
	Thu,  6 Mar 2025 00:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741220158; cv=none; b=OQ4dXwQqBrJLAwgt05ks3weFRT3AQiW2ZvAa3mf49EHUlWpK4M5+Vw1pyNa+xDpcaMAqMz4Z2W7xCIbP7MfoNpiF0h1XXcWOkWL1N8r6j6ukYJNpd7M7jypcytvqsPnVNJ3pYxB6q+8y8HO49KmJ7FlEayMSDwNJHuwtiUPBCbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741220158; c=relaxed/simple;
	bh=favXHBjW2XqGOaXq1mR0Rb2UpGKt6GW39kYnwTEyA+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YXmdQ4DW8c8q3BJqr8BGkk8GiDNJthH/VEthV28VZ7xPSU070Q2rgFrBwAV30Ezsqr6RyiKUcR/ItKfJNFAbMIHtmC9t64JmFsLQOIgTV+oBSPHGVJbvIh+8DRbMBhVG7e07+3+SuzrjxGwMXaKFNAyIjHdX5JZHkQ9vQaaPmkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9699QBa; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2235908a30aso770485ad.3;
        Wed, 05 Mar 2025 16:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741220156; x=1741824956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=favXHBjW2XqGOaXq1mR0Rb2UpGKt6GW39kYnwTEyA+o=;
        b=a9699QBa4Vt7XTv1Rxjn0ugnS+eI+p0tM2z38LThkxsBPiVM3maFPOJFUfWOgXk9mD
         LD12dv7Jo9awmN1lhQ78ej2FPVWNmuXiBOBpMDNCOtxUu77Yi2stCAeKCVlUtGvsR2lA
         Z8nzK8RzP0Mko0LyzirDt6dx6YPrcjAnuRHckotnTcymCPqxCOB50PRgXlwANksDSpdJ
         InMGfNSkWpG/b/LmIXO4N76mTq79Vwvh/JEZL9K2F7BuWTAlonV27+7g60C8AYV8JHPO
         dmZ21v0HsaTYHNCeibNY/7qdX66jswGN9wd6JFqLQc/pP50Nz8egxi8wOZd0X4j40Ngp
         J81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741220156; x=1741824956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=favXHBjW2XqGOaXq1mR0Rb2UpGKt6GW39kYnwTEyA+o=;
        b=SWhTFl5IkpYMkCrvD8ywNfqWcSyX0gXJcPALWuo9HbbkU2IVSoDrc015fvCsTGeIxy
         MSuV/jiVfLPBrDydQp3fMX2il9P5uCzWyBDcP2s8MEfwhjhy0nPROx6LvcV/Ds4wNij/
         UKoJnUUhTMfj80rawSYs6YZBufyr/KosaP1iorBIXKUQTjm09TxqLHDCWJ2S5J2llO1n
         EZygNN0iXC9VV5xEGzuUdVnDkk8ZrFwXSDVHFi4Q9q06Kd9eXuFkmQ1Wrm/Hnhv19d6q
         fLgDbCISnHozbwB+RobTs26f7TQAbnjsCBd9wVNXC21UQ0y/8KrNKG8Dq5pEdTdp+aHN
         y+aw==
X-Forwarded-Encrypted: i=1; AJvYcCUFSR8+IzBB9w+U+F6V6QWA+CtgreHjsO/l5e+2VZyzelLUjdE/1muCfd3WGBpI1z0IYbyYC3xYABodl41w@vger.kernel.org, AJvYcCVGYd2XQMiE0eJBCTe3p16MdY+UBDuTUv4NmCEzM7PTFovMdjXOqOnj7LifG9ypzdJWnjN9pmsgsK1X@vger.kernel.org, AJvYcCXNceVk6NyQkVU4LwJIUIy4Mq60tB5+mhXh3qetozLmdL9JTEwMksr687tmiLSTXrqi/xHuRyXEVo7W@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi42H+LAb6vU9YemLDv4Pb9T78IuW6Pp2dPMei0FkgC5+Rbbat
	YeSizhmJYzqJVhmfnK4CTxY0rMPk8nbC84Ofxfe84LBaNECTnEEB
X-Gm-Gg: ASbGncs6MYOxXnqDZYvJPKDCHO3yI0eBOHFtuGPuS315pCSv4CT1gV6c9V4ZaC1Vn/f
	RNM5WKSZnWeMiSQpfiqE6/G38A79Wn4zJe84N6WQv3tG60XEbZF5pqXDuU9NyNXfFEmobJaEMcj
	ys389/mU0BR3qNNFeUzcHV11dzo3tLqvQvSkWqiy5WcWaZaU/NEhWEVE9EidOUWlCMb3pojG2fs
	1nVIlQyEFLoaQLwWrR+sCmzXZj40uN6toOFXYefzrz7K3gVdci1s1R7Sm3mFWxcX7seIprpnQ32
	or/BnCcdpnSLlaVbk7OOUa6x8wDN3qvCH/1fur1k6b/b63QagC1SId7JXloc3zNf/nU=
X-Google-Smtp-Source: AGHT+IH0KfutgjAyQ57rGNBxxUkmDhrjevQ3H0lmsRe1Jaub+nCdx0wlT3TR/LNg6JGp9CtdqBt+Nw==
X-Received: by 2002:a05:6a00:1995:b0:736:73ad:365b with SMTP id d2e1a72fcca58-73682bf0da3mr7851367b3a.14.1741220155668;
        Wed, 05 Mar 2025 16:15:55 -0800 (PST)
Received: from danascape.tail34aafc.ts.net ([2402:e280:218d:2e5:857:3077:7768:d8a9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698243f21sm46067b3a.52.2025.03.05.16.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 16:15:55 -0800 (PST)
From: Saalim Quadri <danascape@gmail.com>
To: jic23@kernel.org
Cc: 21cnbao@gmail.com,
	Michael.Hennerich@analog.com,
	conor+dt@kernel.org,
	danascape@gmail.com,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	krzk+dt@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	robh@kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: accel: add binding documentation for ADIS16203
Date: Thu,  6 Mar 2025 05:45:50 +0530
Message-Id: <20250306001550.1555151-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304143918.733d6cca@jic23-huawei>
References: <20250304143918.733d6cca@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apologies, it was a mistake on my end, I had wrong dependencies
installed which passed the dt-bindings check on my end when I tried to verify.

Sincerely,
Saalim Quadri

