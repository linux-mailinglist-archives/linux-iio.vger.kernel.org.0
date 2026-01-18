Return-Path: <linux-iio+bounces-27923-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D23D39900
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 19:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18E213009848
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 18:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0B62FD1D0;
	Sun, 18 Jan 2026 18:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzuGYvkm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7C91AF0AF
	for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 18:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768760358; cv=none; b=nfxf/VmJKXY+eqJjEsMn/xuGvN/7F6mqutVKc3JDCWk7JsjMDxczmwyFpoiSW3P83F4i+5I1Z+emJBj91eNB6zCaY2x3HR1zqq7bu9Brj4Ov938AYG1PUQec4Bpl8Za62ScNcJICO0aRAUMLIDwQuFMX+4XzjFH3fgPOZLi/Scw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768760358; c=relaxed/simple;
	bh=uSGCtMuNPYd/zoCaKajgdtdkJjVfLSCQ5clL9IQP8Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B74Knu69jrraq7Br7vxUUswhLfWYhXR22hqtYkYLh8LzaAy5t2gLaH4/eZRc187PvTNfZnNOZ3jdkWnFOR46ybtAN8WaBx1tP86vn8mnuS3CcCN13cP33WvQFOHQpj54LtRXRDbFNKEsra2AZYsw63xq+chNzV9qyx6Rsl9FHBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzuGYvkm; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2b0ea1edf11so5730755eec.0
        for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 10:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768760356; x=1769365156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v5l33lEuRmpkTuX5JOMIIbTz9IQnLRsWv0j331lKa2A=;
        b=FzuGYvkmsx8t62BrCrDKiw/IlHW8N0WlWL14cIhUgcdLa75aK0Ekk/R1gVaVJX0LL0
         wRupgtJK0AEGdBAxZxVOk48w4lTE/w30sGJT4sYunpXZPpkVEdLjV+HYTirK434evm+H
         TjEMYQgIFVRDoNjcJAIeThxESXjv3h9uCblOuEQnXBnSOFsp7wAcI0/EXFumI14mHSt/
         fsMZC6mieHCtt+sccr4w+LPcPMQccjf3YZvlYPeFl4NMAlLrN9Au0b9dQgxYNIX5uIlY
         wlbEz/n4a80VK7p/I0EEtIpYBbvKFVGaLIsbTi3lm9H2qGEw2Ttiec5IbrlJHExTqSQ7
         2I4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768760356; x=1769365156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5l33lEuRmpkTuX5JOMIIbTz9IQnLRsWv0j331lKa2A=;
        b=T1jW2rzI2YNXc1YdpHcG0tNQytqBLBVSlZCMJHvQ0WxBaQHi/7pDSptzIjLjShULh7
         q8OUkcHOikrHqP7nQ7UL1K6HnHaf0LcWtPiiczdPzIF64rFlcdCOMD6Zn0Kgi/IDU+6d
         zcY3gkFhn27d20sNc1DsivRWmM2pZYcedARCspn5RXnV9weCOwqajl/kOjR8S+8zq6t1
         +oK6kuBwEeUqiqAgpb166pYJMRu7eE8xqXv8y4l7ju26dlPCAOWNP4pOiDVGexwhXmv4
         DtaAOkcb3hQ6+XO9/KhOah5MEeJ/NJy3GGjh9kEvfSmjC7VEvAbAKqAsRW9jYEHmQEzw
         Hkig==
X-Gm-Message-State: AOJu0YxUM7l/HJl7ssMGEUSPM8QP9ZPh6UsWfQlalSWiznWeOMt9XZ8r
	tXKEPUeLUfRg/Yt6fXf3ptYk4s5+VBX17zL84q9YP4ZIDVG1+KxFY1kvSNt+rhCgUos=
X-Gm-Gg: AY/fxX69zn2l/4aT5WZVzSJaJ4C14pQpsT1x3RZIFQEtHMK0BwgVl10oBbimTssmM9y
	RYX6c4JS3srGxDVcNViLyxbHo793XAZIdK5W7MoVVCEahfAJi1YvSV3y+XTpor1mRMbO+KUKS8/
	7O/Fcic2Yvwc5N0H8cX0PMbnqhkwdNF+p7Xq5LLj14yB4ig00KRI3TNIPv4YjH+6UnMPDVLmVMS
	rQBrBrExl+47Mjf7wDZk1tiqKT3QF6RdE9DZmUi/EaFkF0yoEbU+6xBkgbi4u4HX8rTDt7vRshg
	IoE5uG85YR0HEgcWYmJ/esgTT7s4qpLwQXEu1lZPNtsIgxpTRZOWQdtfpBKOHIM+nZm8bq6hbzc
	mcamIYDGzVzJt9EvZiM9DnCFugQcIeublYz/Uu/v6GW7dnaFsRdJ5L2dXZTblYCmq+eXCtYms1s
	JxUU+72eiL9PRvO3nzFs0=
X-Received: by 2002:a05:7300:748a:b0:2ae:53da:9787 with SMTP id 5a478bee46e88-2b6b505d0damr6383743eec.40.1768760356057;
        Sun, 18 Jan 2026 10:19:16 -0800 (PST)
Received: from localhost ([2804:30c:2766:a500:b70:8c42:f792:bef6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbd4sm10066912eec.33.2026.01.18.10.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 10:19:15 -0800 (PST)
Date: Sun, 18 Jan 2026 15:21:06 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, Jonathan.Cameron@huawei.com, nuno.sa@analog.com,
	andy@kernel.org, dlechner@baylibre.com, marcelo.schmitt1@gmail.com
Subject: [RFC PATCH v1 5/9] iio: ABI: Update event threshold value
 documentation
Message-ID: <2aadf1fc04e5d091bfd600d1234b94de7c22f233.1768759292.git.marcelo.schmitt1@gmail.com>
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

Complement the IIO event threshold value ABI description clarifying that
raw device units are assumed when the attribute has no _raw/_input element
in it's name.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 20e93000a93e..d746a5e09225 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1062,7 +1062,9 @@ Description:
 
 		The raw or input element of the name indicates whether the
 		value is in raw device units or in processed units (as _raw
-		and _input do on sysfs direct channel read attributes).
+		and _input do on sysfs direct channel read attributes). If the
+		raw/input element of the name is absent, values are in raw
+		device units.
 
 What:		/sys/.../events/in_accel_scale
 What:		/sys/.../events/in_accel_peak_scale
-- 
2.51.0


