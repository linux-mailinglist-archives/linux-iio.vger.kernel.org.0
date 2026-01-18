Return-Path: <linux-iio+bounces-27920-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3494AD398FA
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 19:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D70F93009771
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 18:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2671E243951;
	Sun, 18 Jan 2026 18:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SW58QOHT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB468190473
	for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 18:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768760295; cv=none; b=kreo5xhjhVtiAsn9bfTZ2i4rE/KagN0+QspABuD6RYJUYsfhVi9vVxzy0VcbqHlZIvSnnqVOH7oxhm1FNWv0GqHWSjgoPywIxsF9wZnTdCMif28YN3WZ35Evq3rbxqWzNzvwLgYKmmnW0l1nVsNCo6+melfGMbqdRF5+o7oh5lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768760295; c=relaxed/simple;
	bh=iyexZ1uaucSt1ZtG4+j8aM5C10e50O+oa0HN12eFl4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azI0SfWQOESX65yvTvmekyq/lb5IJVzpGh5CmeIj2jLobRtY8HcZjsxMIg0Jlwck5AeCSjevm+YuNfnFwaFPp+5W10M1fvmoe1SAKj6MszWLSU2Monekqa8DmGVwciRrs8wrNwMNi8w25UPUdvfqf6fnl79nKEK/S1tUKNIKamU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SW58QOHT; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ae2eb49b4bso7994486eec.0
        for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 10:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768760293; x=1769365093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=61kCkgh29ac2ojrati3gqed3KfIfkHkJTk1NnGw8x7w=;
        b=SW58QOHTjo+lfSi4QdWo0qa+d40Kb5L9dO+chg0lTjBFOPuZGqbBBIt1u1PaNwaLs3
         vuiJAiKjrL1W1XKtKpR7uH6T9rIP2WwBCZJ/z1wzwjk/rXoYAe1n0VFEcYXadtLeqqXI
         cyqifk/vXlt8UdirPJM5KuvhmoHrlat6IZM/fkuVfeeLpJKjn4+WKibvLkaj3Ue8DQne
         8dLIEVf1IndAdDLRT/z45NFYaWGrlmjuy7H74qWgyZJ2uT9k7CLe7yXcZajyjfME2xAE
         aGZkdUdBatfMLpTIwVrn8EsTNN+My0HZJt3Ocu0m/MRzFykf2EIwIoFOylBpOCfCM467
         X39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768760293; x=1769365093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61kCkgh29ac2ojrati3gqed3KfIfkHkJTk1NnGw8x7w=;
        b=fhDl/vcUE6j/Db90KBFJuSvd1K0qIhN5/Vtx1qXLeA/LAWUbb/TM/WBlq44dBMk7FV
         Cywa7M0qw797syMCC3kw/IUdT1uaD/DoPgiaGo4C1+f5EJCgSXjttQxQxWE04R6/9jhE
         d439Yt0+7dgBJA53/RN0GE237FPUMqIi0r5n/M9hILh2QG6A1phfkYyVmbsKnlSW6yJ1
         E3jchxj42nHbzhSQJhnSIyLRWj3X3MX3m8z29YR+qtUV0qrp9iBDZ55YdDkPlc20JjoW
         hOdEKiDfMWioyuChi+boFK6YBELVLfHl3YK1t1rYUnaEqkMHzpOzgiUE8s6gPwwMPdjM
         j4zg==
X-Gm-Message-State: AOJu0YxbHDf1r7+5e+7JPJd77iYgpGKMNWTX7ybaAdp4CWsw4lDPxCyx
	HMPigLW/5172HMRW2PKxG37FilIYBtQMdU9FQDxHLU1aiCWsFEO48QP+b8IfnCIK
X-Gm-Gg: AY/fxX7M3e40Dz4rEPB0eayKN9mArOksqacbs0AQAYe4VmXZqHHueoO81S7PmFF/Xle
	JF6NtimKwvF13tQNcLr7lHh6cXJJICTr0KMc+n8Dx/USROms2Vul4nTrcdsoswxFY/mq8PRLBB4
	i0ZHNyWT93boQvt+8A6hyJHP94idX8H/32zvVn4JVfMYh9dE3s8TveFAIZUS4uACpGxrMHmTTPZ
	5fCZ6MxgT8508nYEGTdCXb5MYpvOWqcsnhpPYVSDMf6ERZ3GTfFEsYtfUbD2l9L1ie1Laxb1Ksb
	iiFnLTzITt/jEtqo4Is2dMt6zfzbn60vXUdKDOt2d+/uUCOWA1Q3+VnbpTvDjrEAq6mSMuApZQb
	9d/80zo1jNgHiaPsyxZDc1/xrpozW5Tlr3BQ1C1Deroi6DxCb0z8pK6e17fvHpUZvZIDTZVLgxs
	1H1WZyXM7B87d+aC/L13vVtvJLS00aFA==
X-Received: by 2002:a05:7300:fd18:b0:2b0:542a:227d with SMTP id 5a478bee46e88-2b6b3f21d9cmr9357578eec.2.1768760292896;
        Sun, 18 Jan 2026 10:18:12 -0800 (PST)
Received: from localhost ([2804:30c:2766:a500:b70:8c42:f792:bef6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3651f39sm10000367eec.24.2026.01.18.10.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 10:18:12 -0800 (PST)
Date: Sun, 18 Jan 2026 15:20:03 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, Jonathan.Cameron@huawei.com, nuno.sa@analog.com,
	andy@kernel.org, dlechner@baylibre.com, marcelo.schmitt1@gmail.com
Subject: [RFC PATCH v1 2/9] iio: ABI: Accurately describe in_distance_input
Message-ID: <b38d761e3d78d6121bd3f3de0908a156ad9ea277.1768759292.git.marcelo.schmitt1@gmail.com>
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

There is only one driver (drivers/iio/accel/mma9553.c) that declares a
channel of type IIO_DISTANCE with an info_mask containing
IIO_CHAN_INFO_PROCESSED. Though, mma9553.c provides distance in meters (as
would be expected for the _input interface). Split in_distance_raw and
in_distance_input ABI documentation to provide accurate description for the
in_distance_input interface.

Fixes: 7cf78db585b1 ("iio: Add ABI documentation for illuminance raw and scale values in light")
Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
Added a fix tag though not sure it's needed/desired since it might not be worth
to backport documentation?

 Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index aec39b8e3345..27251b65ea0e 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1613,6 +1613,13 @@ Description:
 		user). Units after application of scale are Joules.
 
 What:		/sys/.../iio:deviceX/in_distance_input
+KernelVersion:	4.0
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute is used to read the measured distance (in meters)
+		to an object or the distance covered by the user since the last
+		reboot while activated.
+
 What:		/sys/.../iio:deviceX/in_distance_raw
 KernelVersion:	4.0
 Contact:	linux-iio@vger.kernel.org
-- 
2.51.0


