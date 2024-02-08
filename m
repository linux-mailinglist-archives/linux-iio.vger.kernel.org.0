Return-Path: <linux-iio+bounces-2321-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2864084E7A4
	for <lists+linux-iio@lfdr.de>; Thu,  8 Feb 2024 19:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0AAA1F29705
	for <lists+linux-iio@lfdr.de>; Thu,  8 Feb 2024 18:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD8185C7E;
	Thu,  8 Feb 2024 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zmpBl/Mj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C24080058
	for <linux-iio@vger.kernel.org>; Thu,  8 Feb 2024 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707416691; cv=none; b=OHGyXTkiyLNYHp/ymHb5hMcXY4ZRTAmqD/B0Shgrhp/yCDtKPSeR2d6MxWtJn+Kt7GIcP2hgR3ooqt9yWPqCr0k8TJAkNNbGe1Loa1j87k75QjlikfGqX8bWKvXNqpD+CZn0y5CCUfFF61BbTf74niIEQ1IrWyqqzlLdFTAkQXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707416691; c=relaxed/simple;
	bh=yWMQ80cejQiWbJt/Fr1QdvyZpIohGyasm9xWmdOoJSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BsOr7SIzGze4eh+AKWGaJBnXs0L/a5SlrQepQaQhKgE74zHnI8k3LAwBi8WQPPkmHwmQw2NbfnjZm+7UZfnAG883pRa5r8zRLe9tUIi9GYQ6grvpOA778bylM+bdt3EX/frE100w9Zq3KbKt9kKI08fZVKb0GNJgqmchLW9LU4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zmpBl/Mj; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-46d103dcbbfso31013137.0
        for <linux-iio@vger.kernel.org>; Thu, 08 Feb 2024 10:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707416689; x=1708021489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFHM46XvieWty5cjkhjt6QqDgG336hB1BzTOOfIZ13M=;
        b=zmpBl/MjyFlZ9KRIRCNgZstkU8+W5DKeUS/cXnDT8ZBMrTYIuw7TFhXCoo+Ov99AGO
         P+U7Uu/uUfhcl+nNTUmw43qtXx0tduzhTnh3R41AfkeIVXUF27LiNinD0ZpXUoDopYiw
         KbfgnY99bEaCzpiz7levzq6Qc/d85aVpbTZNvZmyaRVEfqHBcyg8l+ds3Oq1sljqC+XF
         mCNQQfGIjY69FQ2Imfd5Iye1pefAwmghPjXRS0zq+fGf3Wu8iXFrByQY+hwgJth1/vqF
         5mJQBcBV3t87vCJmvdsMld42L+xU6Wg88pUsyFctYB7ty/cDG/6EAitGJCD0gCu2laXP
         zj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707416689; x=1708021489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFHM46XvieWty5cjkhjt6QqDgG336hB1BzTOOfIZ13M=;
        b=FE9XqJX5OC4TF2NVzZEboJXCjVSkl5Iw3Re6My+UFhRxKH8VdGOAzl6T9jiCPwJp6O
         gUpFd9sVm83up6KYAI3NJhqEd3IRw6hUCOp7838xKQTQrAolPrl+HEO7Cr8e+NkyY9bv
         5oP6q0QYXpr1m/+b/CUi1/yJI4gPYb5hWEYvwXwJkbzSrdlkTuTyUpe4Yx2OCt73aXjy
         bvNv4aXJXEwyNhMc5S0Awaz7oFBpqvgQ0Xc3JdZR0N2lASExlF3qEuYd2kz+UgkAAcue
         P1JjlXEBzYTmgNl8TWltDhNT40vZdmW35d3JOXZzQN2MpPhaTGzhr0n1N/cDYxz0caHb
         yKcw==
X-Forwarded-Encrypted: i=1; AJvYcCX0E8n5ZOvwZyebpb0WNU2aDkBiOZ4OGd6+jSIXF4+91rUAHEds4JxixCUDL9znu6aLFiM5fWnaa2XuKtm8WhbjUW2okhE2K2Ix
X-Gm-Message-State: AOJu0YxlQDNzNQPFuf9xG1jR6dsOG8KH1iExBkcyl1SKDA+m3GDqQDzR
	ptX8o7MTpJHNNdr4qEM04Bv8uD1wcnoudq3bUmwuTcxs9MpEwZwIZhu/zCEeDAk=
X-Google-Smtp-Source: AGHT+IFwGL3vq5/38zSa2CyV8OxDqy0RxXpRamOL+kxkz7rK+carlQoUhdjRFT7uFbBrX0RW5KcB/g==
X-Received: by 2002:a05:6102:2925:b0:46d:3eb2:5d54 with SMTP id cz37-20020a056102292500b0046d3eb25d54mr177122vsb.1.1707416689142;
        Thu, 08 Feb 2024 10:24:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWzB2X/GzY5BrDX8P2pIc2GP6GSVQ3w2E2sFR3L4MS995omOy+pAIG7GvMikxPqhrXJQOObPgOYQPGlIPTVWH+eQdIF2C5QDliZadzcjIkPjf1OJh/cQLTHLMa2rROLGMv7LeGChMLsdc4xDxwPJmxXMOr5yhPWnTEMHojRlXUTwbmslQ==
Received: from ishi.. (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id hz14-20020a0561024a8e00b00469ada55019sm36349vsb.13.2024.02.08.10.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 10:24:48 -0800 (PST)
From: William Breathitt Gray <william.gray@linaro.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: William Breathitt Gray <william.gray@linaro.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] counter: make counter_bus_type const
Date: Thu,  8 Feb 2024 13:24:18 -0500
Message-ID: <170741658084.77291.12361784723046781637.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240204-bus_cleanup-counter-v1-1-cef9dd719bdc@marliere.net>
References: <20240204-bus_cleanup-counter-v1-1-cef9dd719bdc@marliere.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 04 Feb 2024 13:02:30 -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the counter_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> 

Applied, thanks!

[1/1] counter: make counter_bus_type const
      commit: 856132743893a977fe1f1103b3f51b7f0984c2f1

William Breathitt Gray <william.gray@linaro.org>

