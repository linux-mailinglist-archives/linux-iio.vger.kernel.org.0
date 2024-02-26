Return-Path: <linux-iio+bounces-3099-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFA8867F21
	for <lists+linux-iio@lfdr.de>; Mon, 26 Feb 2024 18:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8005285651
	for <lists+linux-iio@lfdr.de>; Mon, 26 Feb 2024 17:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F21512CDBF;
	Mon, 26 Feb 2024 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VbX5F5/D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F111F43AA8
	for <linux-iio@vger.kernel.org>; Mon, 26 Feb 2024 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708969635; cv=none; b=H6z+Yw0OEJNpYW6bUf9UgxpHEpHXr9jpwU8b1OMSWvcgQ7JfLNeoLFOcRscMY6fHA9MJv5Er3qJ0wclzE1T8vXPNMK33bJginx9V8+bdiX3j/FB/1NcP9dlwfgWhKjry6LmJH+zYaehmv3Xc5wAtqX0hv9l8HpCw4GucD7Fc3f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708969635; c=relaxed/simple;
	bh=B41ir5VYbxpF04PAmMUAVJ67JQSh5yH++omCohwmiS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/f8LTkOaR6IZTWWzX/M+/lBVKXxX5rDi8XYZOE1+CSvoXAe5xrkJuxwILZpCLKLIgxBbgJBrPHNgACTz6qG+S/wp/6LoUGfvGoTgrfFzCnvUi+L08wOmYQ57SwIOtuStWl6W1RJgRMI7ZcOfqAqHfga+YIFWyFrwuk4DtYhDIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VbX5F5/D; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e49812ba77so795352a34.2
        for <linux-iio@vger.kernel.org>; Mon, 26 Feb 2024 09:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708969633; x=1709574433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+coxhOY/Hxui8PDFROluhcZaBPd/6HAGgu1JExmMgQ=;
        b=VbX5F5/DZxveCk2tDyNEIm7WztWZikJvS/YRnxBwsZMnJs8Crnm5NwaBubebNioLHh
         ufnUC8Fo+DrZ/XdhakT6xmn6J+w06Iw/038QHNHAHcgR8X/gXKNWOt7gWYHOsIHwUUYI
         eDHouEcOG+q0xBuieDZtKUirxYjDaTLgK98shmMUrdvB1YwWaoWFiAI3jsJnsTQQsSza
         zQKkyJjGukK58k0PXIJ6i6qc528fCAU4XYG4Fr1D2MyVEQgGb2XUR1WdHyfCvbUln7du
         5RLdb/bRkvAvVw0PC6lHZG+zIMN7p9hBTsyHZxdBho3dxLBXBhe0eKAn9uNN8q6Q6acv
         9Rlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708969633; x=1709574433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+coxhOY/Hxui8PDFROluhcZaBPd/6HAGgu1JExmMgQ=;
        b=P4a06KZJMW4ycFXWunniHlwRg5VjZSc8G7El9gpbun5mbur+DK031HhEuseihkY9R8
         6gEnNnk1ZBD3A7W2tgdZEyp8hgcPg0fClPbFQVcRqadwIn/itJwFMnUrKRUgchae4Cmw
         67xnEbtHbY+vOnqc+O3cxDtMDzGgZodHDTKZ8HiD2VTddiAJk0ar83HA8pTguo6hGczv
         SOr92Yn2apNrByQ/kS9U+2vrf3YEjCCp0+psDCSr4z9cqgP6vDGvc1wsPjj4Gdt63Q5O
         DYafYsifn+IXVQfpJAIxnF6D+UdAFitOjOWp09wgT0zF1z/Q1S3lyzPQ+fTcZX/FMXRS
         2LCg==
X-Forwarded-Encrypted: i=1; AJvYcCWgYzAg61bGPUAv9LHX+RGu2pudnMl3SDT7ZySbat1YQyCBNRpaZKIHNhlmUoO1a50c8uVxYxD3dZfFzgGrl7FVjeUCs5iy/YpT
X-Gm-Message-State: AOJu0YytkHhivzkgH/qRSZ6aRiMcXeQPqj2E5Mu7o/gwavZ+6fC0bdoS
	HfGPm/ZTJ27e5QILSYIpDt0nyfssK6apv7GgBmEznVALVLVrwVEVG+U694GGY10=
X-Google-Smtp-Source: AGHT+IFCePGlGVE4lMjTY0/9moCLWOzSCx+v5oqeY2701JqpmJJ2XNiwbKLDRoBfBHN6yiXmmfdKLQ==
X-Received: by 2002:a9d:6c42:0:b0:6e4:8122:c5a2 with SMTP id g2-20020a9d6c42000000b006e48122c5a2mr9142155otq.0.1708969633143;
        Mon, 26 Feb 2024 09:47:13 -0800 (PST)
Received: from ishi.. ([185.243.57.248])
        by smtp.gmail.com with ESMTPSA id t3-20020a05620a034300b00787c7c0a078sm2247762qkm.121.2024.02.26.09.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 09:47:12 -0800 (PST)
From: William Breathitt Gray <william.gray@linaro.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: William Breathitt Gray <william.gray@linaro.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] counter: constify the struct device_type usage
Date: Mon, 26 Feb 2024 12:46:49 -0500
Message-ID: <170896953583.22408.16217091033236084164.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240219-device_cleanup-counter-v1-1-24d0316ae815@marliere.net>
References: <20240219-device_cleanup-counter-v1-1-24d0316ae815@marliere.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 19 Feb 2024 16:52:52 -0300, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the
> counter_device_type variable to be a constant structure as well, placing it
> into read-only memory which can not be modified at runtime.
> 
> 

Applied, thanks!

[1/1] counter: constify the struct device_type usage
      commit: 3bb282ef1149a08a94bc5321b758825bc99c84c0

William Breathitt Gray <william.gray@linaro.org>

