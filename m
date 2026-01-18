Return-Path: <linux-iio+bounces-27924-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 750A2D39902
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 19:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88903300B910
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 18:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8652FFFAB;
	Sun, 18 Jan 2026 18:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FP3pAtjO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AF92222D2
	for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 18:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768760377; cv=none; b=Yc+6SrIZ8HrKCjtc4t2RdTgEK/iLCI88hpj4OV8QO/HVXM9uV0B7UVSPRGXsHeSCUW4HIeGaD5vnwPgNNZ2AJ616YS8gGHTdaYqm4RVsKh7hxrFTOQkXUdH01eoUmYv+/zdGQoclLqkJWOh76YUjttCjEetH+pecj78g2pyt5RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768760377; c=relaxed/simple;
	bh=tGqs5+XIflRlLG29SU6zPmmvzH85uKAMg4yJuip+x0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pl63V24Msz4nLSJslDNNxofBhC3dH4Du9L7ZyYyqc/i74YrihG1P+sqeYAgSaoaXHQjCn0t06yH4NFChn5SLQsJCXYcPeGG1ta6qg0TIPwDt3I0oAZemM0C/ojaBItYd+MNTjyKXdQm+Q9zE/u0PUQk4aPippxQdyKHNbVbgI/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FP3pAtjO; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b0ea1edf11so5731147eec.0
        for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 10:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768760375; x=1769365175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/mzGwh8Z+WSBfKHaEf8o48SzZ9hf9kEvpdxYs2XySa4=;
        b=FP3pAtjOUnz//dd1JMonnZV7wtEEQ77DWiE1d8T8SmYZJWX98go4vFhvHXqtgQq4WM
         lFEG8YbAWzrMRcd16vxHjErDHLWainb+Z0SgozzIF9BSSpPHrO6GSLdPvkWygYetlwCp
         cVq2jZAmGnbv7E5QYWUvY8p1DItkVH5h6cEMYNCfw8sbbadhnwQQAbnBoW7AsJ1EczBi
         DUpk6ua43l9mPx/ihpiYG/MdeGxXP2nvvemxlLkB40DmQNSr4TBSxEp7356lb6XAAfLw
         CFwxEtfBT7AlWrtVTzHf8A93XA2d0/wxTihAEFT6b3NPZWYQ//O44Nc5zgphduxQzR+o
         Xslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768760375; x=1769365175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mzGwh8Z+WSBfKHaEf8o48SzZ9hf9kEvpdxYs2XySa4=;
        b=PQViilZOlHSb9tkfATkc8O6xCPZI0RLF33FhfsbCI1uaFB7/Z7vc+QJqSoqhFyA1Ow
         6G+wtfw0bUEN04iqaLCB+7X8G96aLlFH5TQ9trMuQP9wR8S8CVtbkXdVeDNDRbfBO2cR
         SrRtKNpkQ7thGLzRNNthPWhupT5pxQv4oY1TZVIK5BSmmoRFnaaR9qGv0t0+X81ioN9D
         cGWve6DOiSDHboUYui6YdBUMCNVyPwmF3EDc/ZxpcaNuUT16DmBQA/nP3ADnLdaUsG98
         2NSTvyoijummYgAKL74rXReLnHGtOUsoWWzxNB4K1PmbqrdijH12p/4/GWP9Uj+ZJyIE
         wKCQ==
X-Gm-Message-State: AOJu0YwZkWLcA85uVZuhyvo7+TKdlp81Bf+dnRMhTW4rLOtGftWvGI/3
	kLbhwXPCyaetHMYR/vWmsj6qYQDZXAxU4T2VE14/mPlMODYChC5xbXI0Ymz6G9Nw
X-Gm-Gg: AY/fxX6V4YqdcuO2J4FbuYJpem/f9ocim8UVUZ+el3HKpD7unhve3Qd5+ikmMSbYtP4
	jhtvAJgXBwwjf/fhtvB2sV/Qr0jvCMzF2KkypPrRBUvPFh6MC9M2enTulSujzxTfWgMLgJTVtXo
	7BVKVAyxaHi+4LIIAApLg5G+h01Pqu/zX/asR1mEmtSnPZNNFkF6NHb2X3UAOHGD4YaK5H5igDH
	C80cvjiy/YM/P3Tncz5Sc2O+HWa4dBizQsJQz61R/N9fHjLnPqOATnqqsHyOhR2IWLojDJ4/PjK
	M1yvOAN6w3vvsUyTpYV4x2uD7JNNgqG5QqDUipVOfnFnFBMRFF1TLoOkdeLqji8hr+P4NUz0B+Y
	5LIlIAwpxNWZfUHcPoDx7bF/MEW94Dmc72yPO2S8T1byS+AJRw5ETLIOOlgrZiM1+RyBtjhtL6x
	GtpFZnVNSt934pM+I/OBFJ4mIrWVlHPg==
X-Received: by 2002:a05:7300:3254:b0:2a4:765b:b4bd with SMTP id 5a478bee46e88-2b6b5045f4dmr6708193eec.37.1768760374982;
        Sun, 18 Jan 2026 10:19:34 -0800 (PST)
Received: from localhost ([2804:30c:2766:a500:b70:8c42:f792:bef6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b34c0f7fsm10084545eec.3.2026.01.18.10.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 10:19:34 -0800 (PST)
Date: Sun, 18 Jan 2026 15:21:24 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, Jonathan.Cameron@huawei.com, nuno.sa@analog.com,
	andy@kernel.org, dlechner@baylibre.com, marcelo.schmitt1@gmail.com
Subject: [RFC PATCH v1 6/9] iio: ABI: Adjust event threshold enable desc to
 unitless thresh values
Message-ID: <7443971849518122bafd00a290e9b7a5448c5a50.1768759292.git.marcelo.schmitt1@gmail.com>
References: <cover.1768759292.git.marcelo.schmitt1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768759292.git.marcelo.schmitt1@gmail.com>

Adjust the event threshold enable attribute description to cover the cases
where threshold value attributes don't contain a _raw/_input element in
their names.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d746a5e09225..fd296d8cf51a 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -906,9 +906,9 @@ Description:
 		(_rising|_falling) direction. If the direction is not specified,
 		then either the device will report an event which ever direction
 		a single threshold value is passed in (e.g.
-		<type>[Y][_name]_<raw|input>_thresh_value) or
-		<type>[Y][_name]_<raw|input>_thresh_rising_value and
-		<type>[Y][_name]_<raw|input>_thresh_falling_value may take
+		<type>[Y][_name][_raw|_input]_thresh_value) or
+		<type>[Y][_name][_raw|_input]_thresh_rising_value and
+		<type>[Y][_name][_raw|_input]_thresh_falling_value may take
 		different values, but the device can only enable both thresholds
 		or neither.
 
-- 
2.51.0


