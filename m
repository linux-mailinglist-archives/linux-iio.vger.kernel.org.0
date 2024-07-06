Return-Path: <linux-iio+bounces-7377-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BC39292A9
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 12:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DE691F21FFB
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 10:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F6255896;
	Sat,  6 Jul 2024 10:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIYr+awF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ABA73446;
	Sat,  6 Jul 2024 10:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720263292; cv=none; b=g7ReCXy7bHWPvZ9Xiw5kD+PBFeQjjp4EkIFFUX0MbmZtop7QV+456P+Lm/V0RjHFAX39uXa51XQHwUGAQUudvgH52e2hyyAr1mIlUwGfJKmL/pyW94eo+XUGfaf52OffACOYVenhPRDtVsu66rRkPazxjub3OtRqUvZPb2A9hqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720263292; c=relaxed/simple;
	bh=jeFfXbobplyjA/n9CKA8qoN4MW4Mu4ixxQBXExxKQUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R2575mq+tPpbS99UTjoADTjoW/KzXv3/TmgsTYxDnsACm0D6TXtsUrJlwEKqqCAb9ezcpBV2M8zO2KQx1q+gLXHIM8+2OQGm3VEBBL2vdls22SlvwOWsJhun/WIp2sGsO1tAmnDtTnN7ad+h7QdrhqFOHksJOZoxXFj5zSGObBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIYr+awF; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a77dc08db60so115590866b.1;
        Sat, 06 Jul 2024 03:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720263289; x=1720868089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeFfXbobplyjA/n9CKA8qoN4MW4Mu4ixxQBXExxKQUw=;
        b=nIYr+awFH083/NkmwsSMOvb5cHRQmn70tbuA3wUx8e6M2AS2qh9q9L96s9nbYJ5cDz
         LAfbWWt3oxT5SnjeedH+phj6q1KHlZHeYcr/eHSMywAAmpi/HyPlRY6Nu0G488/1Zrjf
         q+EMIBfH/EqftWBCMI+l0ZSwAzX2eKFJgqkLVpFZOb71smwRkrATL56L9OtcocYjq30k
         nMVyJf9/MM/YWhnR2lX+cY19Y6I/NZWr9PcdAywIEvvXzF/TAxR5V4Vlg/qeyTqAfyj4
         nxrlpgJlyC9hUzM/DrUu/x4vzMFoXbiwrxaFJz3yhHR3KfGAqaeQqKrpItujhDHFNgq2
         LTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720263289; x=1720868089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jeFfXbobplyjA/n9CKA8qoN4MW4Mu4ixxQBXExxKQUw=;
        b=vfB6QMCKqKidMPafRWVkJjvAD0ad7DFAzntdFfmqMlqkff4HZ/RU/tzUjX7nLw7EB7
         /Y2/WiOs1qp+AN7Pjug9apJhassJIDgt1ooCiQhcfgBhFcYUHhwlMMJXe4FQcXAR2vhC
         58diqLE6VgbH1dWPtziS1Wf2F7spd+1JuxK/t/3n8tUrl4r8QscNmgGA7kbROMZgx6PK
         g7CqEraqovfv8BM+HBXB1DVaPt7XkEVoUyHTi6Y2KJzMsLWdjP7l7NZGoDoztkX+PyuQ
         osHK/Kk0hXS+e9tyi/9Omi531GsmoST7aHOAinpPbfGtsbXWYA4e+FE0XavDqkbVxD+0
         rdag==
X-Forwarded-Encrypted: i=1; AJvYcCW6zaLfi4GhaDOvwe7hCfWk9ySbAYHPg48Xb3KUQvwt3kppCktNByGfpoqJwl7DfEvipCg0iD/P3Wp6qo0SS2S8HLymekoAL+kYxG7ISv7QjZJpYS/VdCZBMH8C3rnRBXZPQKLefLg9
X-Gm-Message-State: AOJu0YypqK4oKrsIWZAUAtwRM1TVoFYlM3D4yCFNvzEMB8rPY1cxOCdH
	4uz5fSMJtsnALzTYl7Actv80xRyUy2dc1fyjVEGZzmByafOtjB6r
X-Google-Smtp-Source: AGHT+IGE2RgLXvPXlAq4cpJ+p9NVdhUpv8nSUzPfNhIjmIKEQCmENBqvIXnx9dxNjnFMxhzwPTTc7w==
X-Received: by 2002:a17:906:3757:b0:a77:eb34:3b46 with SMTP id a640c23a62f3a-a77eb343d38mr7588066b.19.1720263289124;
        Sat, 06 Jul 2024 03:54:49 -0700 (PDT)
Received: from localhost.localdomain (mob-194-230-144-236.cgn.sunrise.net. [194.230.144.236])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77ddc56700sm77093566b.67.2024.07.06.03.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 03:54:48 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: javier.carrasco.cruz@gmail.com
Cc: Michael.Hennerich@analog.com,
	cosmin.tanislav@analog.com,
	dan@dlrobertson.com,
	jagathjog1996@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linus.walleij@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com,
	nuno.sa@analog.com,
	vassilisamir@gmail.com
Subject: Re: [PATCH 10/10]: iio: pressure: bmp280: Constify struct regmap_bus
Date: Sat,  6 Jul 2024 12:54:44 +0200
Message-Id: <20240706105444.98483-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240703-iio-cont-regmap_bus-v1-10-34754f355b65@gmail.com>
References: <20240703-iio-cont-regmap_bus-v1-10-34754f355b65@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the BMP280 part:

Tested-By: Vasileios Amoiridis <vassilisamir@gmail.com>

