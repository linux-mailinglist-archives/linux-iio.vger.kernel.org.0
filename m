Return-Path: <linux-iio+bounces-18734-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D22E7A9E3E6
	for <lists+linux-iio@lfdr.de>; Sun, 27 Apr 2025 18:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B287F3B8528
	for <lists+linux-iio@lfdr.de>; Sun, 27 Apr 2025 16:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8880418E025;
	Sun, 27 Apr 2025 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGFwVILQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33874CB5B
	for <linux-iio@vger.kernel.org>; Sun, 27 Apr 2025 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745770015; cv=none; b=ecG3qSalFw6WkIHbZAyfmCaDc7nTi0sjHXC65ZVadRrRm1Ht08p6VGmESEz8hNLWdU/wdh9Wg/Z80bmHS0YIKV1KVeoK3uw6A20WQyqsEMwOx90y0Na2OGR1BABcZfvjvpz9hPzgb6EKCdoQDVDG9/a7nWppc6Cx0RKB/lhdlck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745770015; c=relaxed/simple;
	bh=nBbS3VDX2XzuyXCIvhzQgmT3iIh3W/YvLHs4LIYtS5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MIUd79XVUnIujq4U+mIe+f/iDyog02imiTTRZtZvoVYbqbfZN0C3rJnhqiKBaxKcofQtkAG4tNlCvwTgqgsTqCq67T62flzzrKncaLgBoyuqbATNcG9bE23MaqSTXQ62GUiEcC2ju3mEA77qxeyIjo8kygaXsXnNDDLtUO0SL7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGFwVILQ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7396f13b750so4407570b3a.1
        for <linux-iio@vger.kernel.org>; Sun, 27 Apr 2025 09:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745770013; x=1746374813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBbS3VDX2XzuyXCIvhzQgmT3iIh3W/YvLHs4LIYtS5I=;
        b=HGFwVILQA7hz7INC7NegPnykoczx551221wjaAu/YJJ1x7+UR5c+wKCYpu/aeFT8uR
         PuFdeUUFP0PAOsSwBJN3H8RumNWCE7bIldW042Psa6Fm7oqZY1dRNPT6cCjitn0Dkr7N
         hKaviAMiVG5OSJ2+Ym8oUA1DU+3nO2xDArbmchPHMqcDKLhZyirbzTjtk2gDF9KtsTPi
         vs6TnSw94Mh8E80KrS1nriwUW4Q/T2p1lR9mn72XvbSqgxQC/GcgOab1kplck1ocv0KZ
         9zxgV81Ci2dYpJLAurREZlYg/clUIFB2yy1ZQDJy5LjTsKc1wnxD+h2f4L4pGqfgnM7u
         bCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745770013; x=1746374813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nBbS3VDX2XzuyXCIvhzQgmT3iIh3W/YvLHs4LIYtS5I=;
        b=LckAKrGb3VQl6ASe3HZRmyymFLccgRcDObqw1i/zhTrAPgGQvQ2Qsg0Rq4uMrXu7PM
         CfMKwn8AhjzgpVArehWG+BMJs0Ajj+8q6sD5s7lsOZGVpa3s4pcufX15ahMVADRSKwqN
         KudIK1ieteawGoZ/seI4RYUY94NmM0rqfjdnw6OMzJ12fRriOsa4QANIiPdw4cm716WU
         bUQ+dZm6+8cOuPX1c4vXha/95UWkVWW1x8DHHpi74v9nuMTI8spX6c+L5ed6w1Fjd6am
         2EGJe1zS9nrEHb3kqRsEJU4aEY+E4M0TdgagfBQScQTXp8UYd0JT9nX+9hEgpw0cQIvE
         sEdA==
X-Forwarded-Encrypted: i=1; AJvYcCUsobucpx/oGrykwxEV8qYgwdbxmoD5b0EuSzqt2oXf6HzA2llgMpO6xGOzQWSzc1JR0o3y9UKd/zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBmagjSf1CS/J74xg5JbEm0x3hrVpxKvN+tHrv3iWT83A+64sU
	SKEqczRomDrOFzJHYPm8xtN77nVpyuM/7xW0V7jZGlXwg6E8MrQ=
X-Gm-Gg: ASbGncv5IqwDXDetbImN77z7aMBURIOgs4N48PbIMofPjcoHdqWA3p2db9USoMOCZgw
	SMd1XbY6AgSghinw/5rJLJiOiGNshn1LIpdZbeqRTcAiSmkaORov7UiM0mBJcV4kvTQm3NEYVx3
	yQvba8pPEzoOQJWHuvcOBPsGchOmUVlZjknJCY8XQDHBOKQ89w6dYCIB3hhQ6ApsB/QKeWrB5Ds
	Gk3nZ8SzWIdkKwx2dAhKckienfWhidpg8kG3gBcFgUKRP8MU+fk+FWe2+Sgme7y74B2qkLHEJ4G
	J0TDT5hC5Mjk8fLUphS1buQUQUAA7XOEAzgBJUZClJBdUOAWmBYKqnxINHideN4n0eE=
X-Google-Smtp-Source: AGHT+IG6iwW1D5FsfKuOFr089qduzxWCS0U11Wegk4HOTUrwZozDIwSTi/T1buP63EOXqUL3nAIjGg==
X-Received: by 2002:a05:6a21:6d83:b0:1f5:a98d:3d8a with SMTP id adf61e73a8af0-2045b9f2684mr16415985637.40.1745770012989;
        Sun, 27 Apr 2025 09:06:52 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:ad42:50ef:1925:5a6c:2254:2b71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a9a14asm6490857b3a.131.2025.04.27.09.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 09:06:52 -0700 (PDT)
From: Beatriz Viana Costa <beatrizvianacosta16@gmail.com>
To: jic23@kernel.org
Cc: beatrizvianacosta16@gmail.com,
	beatrizvianacosta@usp.br,
	gabevictor333@gmail.com,
	gabevictor@usp.br,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: light: zopt2201: Remove code duplication in scale write functions
Date: Sun, 27 Apr 2025 13:06:45 -0300
Message-ID: <20250427160645.4807-1-beatrizvianacosta16@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250426152641.639d9805@jic23-huawei>
References: <20250426152641.639d9805@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jonathan,

Thank you for the feedback.

We will study the possibility of continuing our contributions to this
driver. We appreciate your suggestion regarding the use of guard(), and
we will take it into consideration during further improvements.

Thanks again,
Beatriz Viana Costa

