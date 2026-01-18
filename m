Return-Path: <linux-iio+bounces-27921-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CF0D398FC
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 19:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE5BF300C292
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 18:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC942FD1D0;
	Sun, 18 Jan 2026 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4dRGEze"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935B91C3BFC
	for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 18:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768760321; cv=none; b=GiAJfLB82XRi/gMLdwAPCncCeKhIdfpMtaPAD0EMx1dSfC6f7qDHlIgpZoDeQ2LcgDwAg9dl6pyd+3c1ZjPclAXXpJrhzPQCcHXmTLo2B1DTBW8JQ87pIOX6KrYwv4CogN3Ub0vo4mWAzDMkJlOAZVmwlVTZtFZVIdPHDqEV5R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768760321; c=relaxed/simple;
	bh=CtmK6HGYEFLvkcfwWCpQjqpg2mFess9ardwFFVxb/Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B78MhOvf9XTpHq+AoVdKaVufr83uApsskpKRxyX3HGV/gh7Pp1cO5rW1bFTyZiLZo1u6/4lV1XLnYLuI7M5UCnWzsV7JwEwym3wnPAFSYvtx5GAaf8pc18Th3zN7YJVmiuYxrxN266EZQLHUaCXHKZVIrlf0uIZsI98kG8If36A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4dRGEze; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ad70765db9so3499370eec.1
        for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 10:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768760319; x=1769365119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fl7/Hk9e6cLXdvdH4SmgfnpJr7alHem/msvDuO1vXno=;
        b=Y4dRGEze+gLQhUD4Ip/F/gMdcxROj/I16s+AgBVI7/i8XbvO6r41S0pCW/m8IJOE+V
         6i+KPiAW1w2e5Ohhi4a+CpsXKr3rO0UaEkDauiJZrK3rhoOiV+tYisjYdrfc3RFxJqfL
         0zkpAsWX4YXvbU2KXKFpETB0fXx2qFSnMwD/cfU1fXJplxaATSZoVTdys+zkK2Kq0U9Q
         mviz7hWSmpBZ41BB6Cr/JEz5Z8i9YFVisRpK/H6Zrl6cSti3HCzR3HV09R7ogBb3w32S
         ZDOVbaGQuVpu6j+s+k9o5fQTYBcTmBDMa1B0l33DYL+iwXUzfMIJ0p3hp3LKS0Utt+uk
         0joQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768760319; x=1769365119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fl7/Hk9e6cLXdvdH4SmgfnpJr7alHem/msvDuO1vXno=;
        b=n/HWHUeaTyadJ0N1+hWhRRu3q3U8Y5wV/XFoA31iBggsLM06Vw7+B21vYrYkATnmdb
         OuSPSlBl8v5cxydpB6Uis5mCbDJzi22Yh7lI/mCTEo+lED8XQtxuP6+mrqEqFQLl/XbC
         KEVVsbkkijhuCl3FEvyONqG4SKT9JdZekGY/8GRzcVk12Bq64IP77RcdzH7SYaXA4RhI
         ab1uqs4h4+BtJe9ssKBEq6NhqciXz3Dfi8yIUwYd9XBGl3WaB02/awfZJHSuWkVXj6fs
         x14APh42cYiUSYSfDVlK7W/XkauzLAKA0imIgQWwc96QYQwhG21pjgwdgEk0YD9tbebZ
         OE0A==
X-Gm-Message-State: AOJu0Yyg0SgROkgG9IjaBQkfbt7hGELfe4i1YXdrvUWirfh30GD1mkZH
	xV7dijid8gZeBgmfQF+Uy7QqIQVorDsPkp2Q+XUjEnuZSHDYrY58aZRleb5PHufQ
X-Gm-Gg: AY/fxX7Hd6J1A3Ru+osYC3qYrycyQXA2CBAeMnA4DLKZooeIKEx5MGjZkvLLDQHNtGk
	4zl2nPzURU5UewYyK3zfvno0AnBbw/4QlxkfC3d/HSovUU25N+kkkYNisq5lEshURA7Ke8CKISU
	9lLXsJg0HQxxkynoE9U/ZcxNd/P2XILu8NkrIjBdA0nnFt5gZHpiHgenptS+6YkruFEb7Tb9cJL
	djGZDeUzMmV0rqXMi7kfpslrQjffM1032fKIiHXcnwf1YZoqJS6Odz2ryqQlnht5Xo7PHKETMb3
	NTB1lGj45+NdG09jHJOiMcoLhmwGSXw3O2V/Etfd4CPwLdKgfwC9vAszu7brV1PHisPPirs1vAQ
	nNCNtC6kyQHprbyajj4pIfQeHISp5U5+sdAYfxgX58KIvf8liHDAE9cE8SvlvYWVn7P4SDhB53r
	otORWUEYNxSXLGi2scSPk=
X-Received: by 2002:a05:7300:c86:b0:2ae:5275:6901 with SMTP id 5a478bee46e88-2b6b503d29emr7165886eec.34.1768760318788;
        Sun, 18 Jan 2026 10:18:38 -0800 (PST)
Received: from localhost ([2804:30c:2766:a500:b70:8c42:f792:bef6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b36564ffsm10024081eec.28.2026.01.18.10.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 10:18:38 -0800 (PST)
Date: Sun, 18 Jan 2026 15:20:28 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, Jonathan.Cameron@huawei.com, nuno.sa@analog.com,
	andy@kernel.org, dlechner@baylibre.com, marcelo.schmitt1@gmail.com
Subject: [RFC PATCH v1 3/9] iio: ABI: Accurately describe
 in_illuminance[Y]_input
Message-ID: <806ebcb6b4c9b2412fea92118b0d15678729a6da.1768759292.git.marcelo.schmitt1@gmail.com>
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

The drivers that provide channels of type IIO_LIGHT with info masks
containing IIO_CHAN_INFO_PROCESSED provide values in lux through their
in_illuminance[Y]_input attribute. A few drivers provide both
in_illuminance[Y]_raw and in_illuminance[Y]_input and those also provide
values in lux through in_illuminance[Y]_input (as one would expect from
_input interfaces). The documentation, though, was previously describing
in_illuminance[Y]_input attributes as if they would only provide values in
lux after the application of offset and scale. Adjust the docs to provide
accurate description for IIO channel in_illuminance[Y]_input interface.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 27251b65ea0e..9fb12f7a639d 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1652,8 +1652,13 @@ Description:
 		application of scale and offset are meters.
 
 What:		/sys/.../iio:deviceX/in_illuminance_input
-What:		/sys/.../iio:deviceX/in_illuminance_raw
 What:		/sys/.../iio:deviceX/in_illuminanceY_input
+KernelVersion:	3.4
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Illuminance measurement in lux.
+
+What:		/sys/.../iio:deviceX/in_illuminance_raw
 What:		/sys/.../iio:deviceX/in_illuminanceY_raw
 What:		/sys/.../iio:deviceX/in_illuminanceY_mean_raw
 What:		/sys/.../iio:deviceX/in_illuminance_ir_raw
-- 
2.51.0


