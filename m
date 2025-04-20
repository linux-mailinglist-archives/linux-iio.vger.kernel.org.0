Return-Path: <linux-iio+bounces-18369-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076C8A94774
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 12:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C2A5171D87
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 10:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E879202F80;
	Sun, 20 Apr 2025 10:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIjk3613"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C724119307F;
	Sun, 20 Apr 2025 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745145888; cv=none; b=WCMVMBwxNxyxgapSrkONn6ZyF0pFurwvefjn6WRTAox8qCYfn34cVtLxkNJjy1/q8HoL8T7wlVhvI45QtsBUJDwMvFFBCD1oiKEKIVSu/IC/3DSvZAanX0yP7P1POP1Fvc3YHO3+1ZmhAObQ5vmP8NwMZBILarIjy2ALQkdwNgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745145888; c=relaxed/simple;
	bh=mLPezQLhmhvgO0exVl/AQmD5xWtH0OgY5GWGxgf6WS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WkuGsGc3uWeQ/njMimd2NmKAKWUbzoCJ6mM2HEX4531XDb0QK5FsXOQD2ak6IWYkaD69gdqZFwSgaoaSCaxN15t89Ei9AttpIIEtVHYcxcxLcnoY5d8SUTRiHMh2eq6qrlpYtRXq/1ND7ElbBprZ0vazvfZ0Kx/tShFNswudWDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIjk3613; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-73972a54919so2592470b3a.3;
        Sun, 20 Apr 2025 03:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745145886; x=1745750686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cn3EZ9GSZ3fBYC366WkmVBMTpNq7V5H65j8ZNSi0Wso=;
        b=XIjk3613kN0ljiMgAE3tFOhzph/Dn6E8YnQMUrkfY6xAgHjKzv4qod3vOAdnCbtI4V
         LNRxXRu4CIKmrPJdikCZSagIfYoW3Dk663W9Q3XcRMUU3EdOTzvbu1qTs8vhDdkyIfO1
         tWrTMgxBSxQz9lNOui0zjy2m7ezvGXFM7O30zfrvuquD+THhsI1JrmlZpDn24oedQ95w
         3opw7utIuzbuo8shmr+ZkcHyg68L5xbZ4Xm33G0svtKQDzcxO1vCGgcOQPH5XJp3NcT0
         PGpUelooqateuyJxf//v6ENfIF0r1DT1/sbj5bCPUrKJL2Z17orBDooivjEukJavNYkH
         5sNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745145886; x=1745750686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cn3EZ9GSZ3fBYC366WkmVBMTpNq7V5H65j8ZNSi0Wso=;
        b=eRbw3iiMwuZuwE+xKTkpLKaSCi9AZr8eGFJmoM68RzgC9irjCvccOA2RfZ4/NgU+30
         4qy/DyQxWljuRb19tpo/z6L7fN2Lnt4bMgNHd+iWaPSNYIv0UGa/ZE/aXFSSc4R9IW3Y
         I60idZjH0tpftwgxs4yjfiirm6jOxEs9mziHH+qHqpRyFYdnYuFGNpizd7B9KprEwlkX
         ND94HR9+xlQAQfNNrhVTOzrE8s/rXx68rwS6ua+/w995EZ6AhVOuYgXX9FJhpGfWlUG/
         EChenDeS7M2rRNfqW3GuKPU7rRJvBtF6giNwcVQxTxddTRXx4LaYmt1gaRd9ShBwo5aI
         5iFA==
X-Forwarded-Encrypted: i=1; AJvYcCXipjHMDbiFxm8/jbj287n5WKOrc3b1yLTLd9ZDg8R+QGarAc0sawA4vcO9pgc5o3i0fMltIY+dZoL2@vger.kernel.org, AJvYcCXvBeaAALpnvplRTLReCZY+CP5oPULGexudtKFaNwT9tI/4fLzApq0BeKP6VcLYAwk3F5HwDNwXI47T@vger.kernel.org
X-Gm-Message-State: AOJu0Yy07g3PH9972Nqv1x3iD2fi/WlPGA3V9SGY00eXqd0fyO1SXihz
	ymBhAFqOvdyE21e/iitshF7Q6Z0LEu/TZl2rrCA3OpGbrog3gPjx
X-Gm-Gg: ASbGnctGPbdel+T7NJCwEhuxTCsx3xTqLNsX1OMCk8UDDLgTno7SqdCddQ7djJtQBrL
	/p5Gtzs2lLwBF0ry8ypnlki115SaGEuCr6lKbYufuMgQQINU46aj1VQ/X5RAMexN3y/YeYN4PI2
	Pa8kq+s+VoVz1U2b10mIJr4LFjpty2jZQYbqXHNcO50sDrU8EcE9uMvPxaVBQ6O5LrKIn+EvMtg
	tiq2+8h3ytkY9/DUs7JpV34UkxtojS5X87+6/PzQOqZSY9em49Q/Ve23y6t0hRGmyrkwIXYcHdj
	LVitig8pxS539BG67NblpTPd159S5Yc9Bn8PPLEN9lohj+M=
X-Google-Smtp-Source: AGHT+IFW6yxD5Nwxh+PBhOo9fPqGTxsPuKivohBRY8OnF2aJbCHY8tLKNvpW03pcx0qVMDfrPLVlbQ==
X-Received: by 2002:a05:6a21:3399:b0:1fd:f48b:f397 with SMTP id adf61e73a8af0-203cbc76991mr11222029637.23.1745145885911;
        Sun, 20 Apr 2025 03:44:45 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73dbf8e13b5sm4504061b3a.48.2025.04.20.03.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 03:44:45 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: andy@kernel.org
Cc: Gyeyoung Baek <gye976@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH v3 3/4] iio: chemical: add support for winsen MHZ19B CO2 sensor
Date: Sun, 20 Apr 2025 19:43:59 +0900
Message-Id: <20250420104359.376766-1-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aAExr-YPkYAsSQTc@smile.fi.intel.com>
References: <20250409024311.19466-1-gye976@gmail.com> <20250409024311.19466-5-gye976@gmail.com> <CAHp75VfMHdw-6vrELbjjD3T323uDz7U9wRP5YSk2jZ26wBuLTQ@mail.gmail.com> <CAKbEznsVxexdrXX72G-tCUHjznx6na1h8MrCFPKrHd27GXht8A@mail.gmail.com> <CAHp75VeU5sERbVz-4OxkJNC-pjT3B5AvfAMj09LXd6v4MdeDeg@mail.gmail.com> <CAKbEznvXdfszfiuXma_GWhYLwj7mR_WX_H4r6iHZWKp2=41tJw@mail.gmail.com> <aAExr-YPkYAsSQTc@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > It seems that the serdev buf doesn't need to be DMA-safe. I looked
> > into the PL011 driver as an example,
> > which uses DMA, and found that the data received via DMA is firstly
> > stored in the buffer within the 'uart_amba_port' structure, and then
> > copied into the 'tty_bufhead' within the tty_port. Later, in serdev's
> > receive_buf(), it simply copies from the tty_bufhead to into serdev
> > buf. So I think there's no need to consider DMA-safe in the serdev buf
> > itself.

> But who will give those guarantees (note, the code is most likely may be run on
> different UART controllers (PL011 is just one of many), have you checked all
> supported drivers for DMA?

No, I just checked one. 
Sorry for generalizing even though I'm not sure.

> > would this make sense? If so, I think there is no need to change the
> > code related to the buffer.

> The bare minimum is to make sure this buffer occupies the cacheline.
> Read about DMA safety for the cache coherency.

It seems appropriate to use '__aligned(IIO_DMA_MINALIGN)' to ensure cache alignment.
I'll use that, thanks.

--
Regards,
Gyeyoung

