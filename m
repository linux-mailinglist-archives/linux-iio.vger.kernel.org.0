Return-Path: <linux-iio+bounces-18356-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA0AA94622
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 02:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A72175DC1
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 00:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40420FC1D;
	Sun, 20 Apr 2025 00:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPdnOaeP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F3263B9;
	Sun, 20 Apr 2025 00:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745110372; cv=none; b=aH2C5YjQh5cbbONRYBdatdsis+ErfE+L1rhUuqBcvLrNip4m8LOp3SGYRZTXK0unmCL19wKPkhb+S89WDSh4lbzWg7L1tufVWcbMDq0Niu4u2TrOOyK8LWpMztcAHR4IyrrxFqU7xlQCxfPX6jt3eayMbj+ojPMDF1YHzD56UFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745110372; c=relaxed/simple;
	bh=CwlbY0fPd8cTaYgi4MJrB4MplljLJBVxwDgrw47Ao9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhEp1UpTnGLNPKMmnheCJS0UM8mgn3qgWG4HPZBJOVnkjsavj5LIc7Ue30l6rLEKYI/szzSlMOFDbL1HX3MmZ0OU3JByktCXnb8FPQfFiSv5eFbwcbBXClyyDSpxFfh1oAE14hkLja3l8XX5IdS5UI/2NrbdYR1Sw0b3BL+BirE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPdnOaeP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-227b828de00so30938395ad.1;
        Sat, 19 Apr 2025 17:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745110370; x=1745715170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCEcEMEu0T58jlK4WSPJn1HU+qrJIQ5pWFvzDqCoZx0=;
        b=YPdnOaePV8q5tfwAqZdOlN4BW2PVRwC8e+Xs2edNI8zivFOmJN5vgj+/ErqizOePs0
         W98JnOExnc6IdpR5eC6KxCqPA73E/oqf1HN1dQ+RS74Cg8Fehg19LmYuv1/VT4lpXgLJ
         e8UaqxEv9uAZ3C08T0go1QmN0plsigyMU6Aj9/ccksgEntyJvsrAw/UactRRsy4WWrJ9
         XMhCNjIo0xmnUPFnqby6S7cp/n8JScBgKbJpxhEc6u9gRnGtdWH9TAdSRH5GrxtM0jRI
         aeDTnEEiH6E5mRH4BkAlRa64MkClYRk/UeXK4YVKd8qDf3bjmzciZ71bhaK6nmLnWP/y
         csiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745110370; x=1745715170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCEcEMEu0T58jlK4WSPJn1HU+qrJIQ5pWFvzDqCoZx0=;
        b=SgJVz1QOsT0Z9CYvT6Bpci6PoC6KzxVgB18QNX2AjSwp5I4oqypj7NH7BPTGvfkcwG
         TrqBZiwWPY1ANbPxeJhF1Oux6Mv8HDk5WBVDKkAkcZcQFY1pdG0XNz0hK1eMLNRs8VJs
         VG9T7hutuVVF5cgV9rTXlBajn31xVJSXhhfJcrdzqOqdQe/H0HxID69q1Z93372pZ4I5
         BcGeMAnPci6P0GZ/cdh+jhL+cQhY01qoOSEzxm5G5rywqOV6r51sa9s1T3R9ojxP8m3D
         97bulkdpYTH4XqXKeOX6Kzse6RFrjxLPOZEX32F3Fhd/yxxkxmUOI8v8HdNoovVslBFa
         cwwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVm5fZXxofxYklF6JpzykKzUbYuFjct6/zdXbWggGJ410ONHKDrOZMJ0l4qDTnuO7WycufmAj6@vger.kernel.org, AJvYcCWfPQXsDtOEJlQNo1uPt6lvBLyDXPdEGPYFljTJCS0ir4T7IT69RvYNNyjg/QKBn8syKemNiAYaeko6JgBX@vger.kernel.org, AJvYcCWfZnG9YMmewRVtmowagJWfajcqn/n+Xcbq6pXMfzu+3dV3ler/V+XUjAxJzsv3tMWFCfq72m5BCeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVL0hyMw+QTv3Fpi9Uzf5Osncp2RcKm4zstxaXiomM4gfKsewM
	/vhtgb10Lg9IAv2uDvXJuveniaAe25GEOJc0MB59xlQS9kp33QX8
X-Gm-Gg: ASbGncttU/vJbs8OuKnF4hhhkTtgNQyQxZPY8/ZSuAwdQO/EhbXMUA/p4iaMr1eeTir
	Vc2Q1sERe+OMlO8prgO9VuZnBnhLSURlVO2YrLMfO/fZt05KgI2XPJ+/KhEEwC1/Xa3gsqDlKOJ
	x+1f4T0I0SvRz6pQfFZRvagOt/a8ANPlgLO1/EaF9dg9pQrmTQkwBggv+CsusNiBqceV66csvvz
	mpkeUUsg6zOpX8EspB8z7NSsPcA9rR2WbR3D0gApUR2syOh1wrzI4rkslOXBgInPOpCnlbMmuBP
	e6JSnmHbeXgNTqLF0XfdGyFd6my1RMFjfwstfDf5rVN+EKg=
X-Google-Smtp-Source: AGHT+IEKuOjMisIHnkcON6V5W+EQxT7CT/sccCGEABpJ9C2IGfj8njkW9qdh/ZaY13cBUxDKtNkxhw==
X-Received: by 2002:a17:903:250:b0:224:1ec0:8a0c with SMTP id d9443c01a7336-22c535acd5cmr113719415ad.29.1745110369690;
        Sat, 19 Apr 2025 17:52:49 -0700 (PDT)
Received: from localhost ([2804:30c:90e:1e00:5265:5254:2e32:7e5])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22c50fdf1f1sm39487585ad.237.2025.04.19.17.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 17:52:48 -0700 (PDT)
Date: Sat, 19 Apr 2025 21:54:00 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, Michael.Hennerich@analog.com,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] staging: iio: ad5933: Correct settling cycles
 encoding per datasheet
Message-ID: <aARFqG--oRuwhUmR@debian-BULLSEYE-live-builder-AMD64>
References: <20250420003000.842747-1-gshahrouzi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250420003000.842747-1-gshahrouzi@gmail.com>

On 04/19, Gabriel Shahrouzi wrote:
> Implement the settling cycles encoding as specified in the AD5933
> datasheet, Table 13 ("Number of Settling Times Cycles Register"). The
> previous logic did not correctly translate the user-requested effective
> cycle count into the required 9-bit base + 2-bit multiplier format
> (D10..D0) for values exceeding 511.
Hmm, the above description should probably go on the refactoring patch I think.
Otherwise looks good.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

> 
> Clamp the user input for out_altvoltage0_settling_cycles to the
> maximum effective value of 2044 cycles (511 * 4x multiplier).
> 
> Fixes: f94aa354d676 ("iio: impedance-analyzer: New driver for AD5933/4 Impedance Converter, Network Analyzer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> ---
> Changes in v3:
> 	- Only include fix (remove refactoring which will be its own
> 	  separate patch).
> Changes in v2:
>         - Fix spacing in comment around '+'.
>         - Define mask and values for settling cycle multipliers.
> ---

