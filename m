Return-Path: <linux-iio+bounces-4754-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7109C8B9B49
	for <lists+linux-iio@lfdr.de>; Thu,  2 May 2024 15:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A21531C21CD0
	for <lists+linux-iio@lfdr.de>; Thu,  2 May 2024 13:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B1181AC7;
	Thu,  2 May 2024 13:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYWdUe8W"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D505FBF6
	for <linux-iio@vger.kernel.org>; Thu,  2 May 2024 13:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714655121; cv=none; b=fN1CSZ/jLfG3PAafRKJ2MbH14KqTU2qEc4sx8gHDOd3YMbwkNr5jqke+ByFmzCzEd3jOMd2671pE5VRc9LtzGeaoVFdrKB888WZ83VjzxiVzLI3r9vAcB/LCk/K4jRbiXLugwoE2wk8oZJK4v9W64RcT+0sCanbb4bS4kP2En7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714655121; c=relaxed/simple;
	bh=2EGrKQ7yQPKr6lvZQswU1D8cfTChbdI5mq9M0qfQA0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t+8pjm4xWuAjUHU14dTT36Wq3LqzY6wGz1EiKsBr0x1PYTo7gI7v/1Fe3d7znAfg6KcAbT6EuEoJ9MfESkk+Mi4YDLTE5d2qchQRdFEQhPWThop8v0pNbktQLy/2L1oBFZXx4dOllqchUQeT+Vlm+xmkQx3D6qlUZkPjBARwKDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYWdUe8W; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a55ab922260so1055131666b.3
        for <linux-iio@vger.kernel.org>; Thu, 02 May 2024 06:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714655119; x=1715259919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EGrKQ7yQPKr6lvZQswU1D8cfTChbdI5mq9M0qfQA0w=;
        b=cYWdUe8Wm+/e+uwnag2Y1HDZVNoZC774GgV1DTBXnND2KSB4Bbisrkb23/445WbNbj
         9XgYX1fy+S4TgXqdNWJ5MIM78XgEuwRbfATdO5cqkhfO8Le2eznQX9k2EdxnZhZwlaxB
         /jHi5m0yT50bZZb51j9uohEw6phxlFLG9C7cE2Mr/78rzAjCCUEDyaRlPqJLMvoNwUjV
         Pf4pbDqE7aVeqKM325eqLYUgBb8smL4wD+hPWWDqbCjP/QjQ5awjvxLEyMcqRay6iVzF
         XEdyJ2WfZ5eWHYUk09cuO4QJ2USFbONCgbkVqnVlmXWdU69c5tNVQm046ncFwPyYCoTH
         j1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714655119; x=1715259919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EGrKQ7yQPKr6lvZQswU1D8cfTChbdI5mq9M0qfQA0w=;
        b=spXbCZdabs7BxKBgiFxMmCvY834YK6yfy0Ah39xbcxyN/noqCxUZunvVsNdzb5625M
         HP1YAH9NYNhsoS/hWXvcxEaZ7kGFnmT+Ce3xKou15FUtPxvofMt9FlhiMBKaNBX9g9M0
         /yw71NPwZ7JAwdM9HgUVeU4ElMty2itRcYqdpiKtv9Xt3/ExEkDJt/g102wdynPZ9E7s
         Stp4iN/dFirBPNAezkRr36PsjkEc837diUB1eFW63V3jOEnXZW2veMhE2bqzfDu5JyBj
         zXsHxYgX/7W15HoJoMBrBJluXjH/4UygvfaPu1l1niS7tpcA0K2Id4hNy2q7QFclxcxc
         Bu4g==
X-Forwarded-Encrypted: i=1; AJvYcCU1VbJt8bkb+HQp1dpdWLX69aVzl0KGvGgGy2PFYHdGhT3K+x/pKmUYnHyQLiNQbjc8eviHsu53lbxwY3NxtTgJl28DXWsxYVtI
X-Gm-Message-State: AOJu0YzQ3rDgNkNfhNFnjU+daOpMUyjWt428EHxq4OdVdKa6v4QkqAzI
	fbdUboLTY7JhfMmcQEechCuS/gnjNhq5F183EUfUdKa90f2730eZU/qVeQI/
X-Google-Smtp-Source: AGHT+IHAN1muw26lf6BKgOEHDO9lG2viA3TpucaioUEvhq9RdCJe4zZtS+BuBpo8mjsR1e1JyTMcOw==
X-Received: by 2002:a17:906:3c4a:b0:a58:c696:9aab with SMTP id i10-20020a1709063c4a00b00a58c6969aabmr1477273ejg.15.1714655118501;
        Thu, 02 May 2024 06:05:18 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:9b84:d286:909b:17d1])
        by smtp.gmail.com with ESMTPSA id j1-20020a170906474100b00a55892e840bsm526846ejs.205.2024.05.02.06.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 06:05:17 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: ajarizzo@gmail.com,
	ang.iglesiasg@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: Replying to: [PATCH] iio: pressure: bmp280: Fix BMP580 temperature reading
Date: Thu,  2 May 2024 15:05:15 +0200
Message-Id: <20240502130515.140852-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240428144015.4f0e6681@jic23-huawei>
References: <20240428144015.4f0e6681@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi guys!

I am sending this e-mail as a reply to [1]

I know I am not included in the mailing list, but since I am working on that
driver currently [2] and I am also reading daily the iio mailing list I found
your patch quite interesting and I wanted to test it.

I managed to generate a negative temperature for the sensor and as it looks like
you are right. Before your patch, the return value was overflowing for negative
temperatures. So, good job!

I have one question though:

1) The comment that includes the "milli Celsius" is also similar in the
bmp380_read_temp() function so maybe you could change both. But since it is
a fixes patch, is that necessary to be done in this commit?

[1]: https://lore.kernel.org/linux-iio/Zin2udkXRD0+GrML@adam-asahi.lan/
[2]: https://lore.kernel.org/linux-iio/20240429190046.24252-1-vassilisamir@gmail.com/

P.S: I don't know how tags work, but if for the tested tag the testing that I
did is enough, then here is my tag:

Tested-By: Vasileios Amoiridis <vassilisamir@gmail.com>

