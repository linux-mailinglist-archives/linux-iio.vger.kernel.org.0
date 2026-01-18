Return-Path: <linux-iio+bounces-27919-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB331D398F8
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 19:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67BAC3009487
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 18:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581162D1F44;
	Sun, 18 Jan 2026 18:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8Ih6imD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09FB2222D2
	for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 18:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768760232; cv=none; b=Ou4xMWUlkKdZwWXyK5csLIvI7NwOS+wDYj2Bil0o//fJ3l1FloUvi8Z1G6XDkLXwQr6A5o0OBhGnZTNPYMiGarBJ1ioCtwRniXo7kwq+06ZGrFHi6ywKgSJjpn4VtcG/x2l5zxrSBvigGfHc777sMFg3wVwIKtJiI569Q6ELnDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768760232; c=relaxed/simple;
	bh=bNqOsf+Er9T/BicBQu+jS+4NqWSZEqVuapxQWYxf19M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UlNJ1QhrPrMPQBwBwoaCD6AzNogpiYJZctZlm30dmOduj1NSWI/m7EhVdEME4S2QCzWcdNjQlwYc0mlcB0j0G3l/de3foR7/cHnpTe2qkPl6nri3IiFhbqs1PL8W8qv8zcXGMX21yYbTrwlEDSc763RcJ4aoQ7X++se14/J39b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8Ih6imD; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b0ea1edf11so5727666eec.0
        for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 10:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768760229; x=1769365029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xq8sPvdkKDXB1kDhAQYhIQZLysAVgLtJrDRRp+zcM8k=;
        b=c8Ih6imDgKwmlhlPkNJM4GvBgp4b+CCTWnyw0bgC0/r7DfFvq4SI7Ek7o7pD3Le/Ra
         Vun0xuiJ52KJ2ULj89x1zzgHR8BbN1QCPS1Y0McFfspwLwc2uJo8O3JWlxOe37m3SdX/
         ch/FdaFdOv24CpUr9wtmuD/hehyCdrLVxEZC99mzB4Lifs2D/c4KtiEYVQ5tFAr1+pkn
         1SyFOP6qhxqlMU/zZ1z7VNnSPAlgbb6LqfyEq1CyJbc90Y4ODXYON7NeL3DeypYKZYAa
         5XstVEld0S3xp0Jl3mpTAa7Wl5iUeAcbrKZ3dr5FFG5dOObkQroYFif/r4w8mfORSwPX
         927g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768760229; x=1769365029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xq8sPvdkKDXB1kDhAQYhIQZLysAVgLtJrDRRp+zcM8k=;
        b=m69It8PC0Jej+XW3ujQKQcv1uScKsW3ayJGbnX0LliZ40Acts/fsb1dSLUC6T9pAFf
         AumoKyVMMeoiK1cxB+0HmiC7DTa3LzWM1DReHw8WTkBxM9eJGnyXGMvhpo9zsjE0TlKf
         GEMSe5TQ3yB+KjaRO8iwi0Hx3Uvk+XCzFyEqPJ5Bjg1V1ripRXxc9xK2L/aae4tFUrQX
         4psZcyabBnv+OMYd/gYcN9sAiDXIpTjcsu0SUKeEDW3q8D87k+kcP1fNt3pdW5Ytd+ls
         fiMDiDduknbFW4DGYmbTCGC1UfLXoMMlAHUuBvWRU7JUaXoTg7xfu9etyPMpRuvmOdUJ
         oWFg==
X-Gm-Message-State: AOJu0Yxd0EyKlnh6ghuCKhoAmLewETx5KxHgWZODIfzF0cxIqOLXni2Y
	niB19zmjaYNXjmPNtYCcnuybv1DUkCbEj33PTNzrFSjgeWo7B2ARpWdSDpFWXalq
X-Gm-Gg: AY/fxX7Wphwqt6kpT43Sp2dRlzAABh/rppoetFIRMLvipHfie7uSDhHmGTtyTpGje4H
	9FS2riixXenfMXt81X9AA8Q+CRQKbufpajYbmusW0R3IX2Io4zaq6vF0NOdDdU2shafdrNhgKjL
	wYzeOsZ85iB4g43Z89x3NSil0UimyO9tfjxKK+kFTOQMYzLQiDUWdNboFhWKlC3LLKvdYpnZRUB
	YRF/x7phvIXGmemx54XfSheuIowJTXvxS5PFnk+XF/+PBi3WBnF/GCU5PcIV6WvRmEExhSq8cEl
	uqdlkEUkrsPLKJajVLKzZ+iZW8OpUKzFR8i5lObutL3RKMGnVGzI7cVlqIzVlv0Hvb4+Kd61leD
	cd3pzYya+lmZ80FJVieYNC8ulVCssg/9DqLcAQX0TnQ7rdld8AiyRsCl74yX/pmETeopC3vifup
	QAFFJSEHXUdPPXp2RfJYm8B2kUzIkSgQ==
X-Received: by 2002:a05:7300:23c7:b0:2ae:56dc:eb18 with SMTP id 5a478bee46e88-2b6b5002350mr7923289eec.21.1768760227678;
        Sun, 18 Jan 2026 10:17:07 -0800 (PST)
Received: from localhost ([2804:30c:2766:a500:b70:8c42:f792:bef6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b34c11c4sm9958088eec.1.2026.01.18.10.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 10:17:07 -0800 (PST)
Date: Sun, 18 Jan 2026 15:18:57 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, Jonathan.Cameron@huawei.com, nuno.sa@analog.com,
	andy@kernel.org, dlechner@baylibre.com, marcelo.schmitt1@gmail.com
Subject: [RFC PATCH v1 1/9] iio: ABI: Drop unused in_energy_input
Message-ID: <c4bd27e1a0db2d50ae9130ae49188ba33d796a96.1768759292.git.marcelo.schmitt1@gmail.com>
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

No IIO driver declares a channel of type IIO_ENERGY with info_mask
containing IIO_CHAN_INFO_PROCESSED. Thus, in_energy_input has never been
seen in user space.

Fixes: 72c66644673a ("iio: core: Introduce ENERGY channel type")
Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
Added a fix tag though not sure it's needed/desired since it might not be worth
to backport documentation?

 Documentation/ABI/testing/sysfs-bus-iio | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 5f87dcee78f7..aec39b8e3345 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1601,7 +1601,6 @@ Description:
 		For a list of available output power modes read
 		in_accel_power_mode_available.
 
-What:		/sys/.../iio:deviceX/in_energy_input
 What:		/sys/.../iio:deviceX/in_energy_raw
 What:		/sys/.../iio:deviceX/in_energyY_active_raw
 What:		/sys/.../iio:deviceX/in_energyY_reactive_raw
-- 
2.51.0


