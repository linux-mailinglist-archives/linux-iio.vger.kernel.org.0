Return-Path: <linux-iio+bounces-26996-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF58CB3D64
	for <lists+linux-iio@lfdr.de>; Wed, 10 Dec 2025 20:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E50F4301397D
	for <lists+linux-iio@lfdr.de>; Wed, 10 Dec 2025 19:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E0A326923;
	Wed, 10 Dec 2025 19:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XURVwJ8M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE83930594E
	for <linux-iio@vger.kernel.org>; Wed, 10 Dec 2025 19:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765393956; cv=none; b=IoqYwL1mp8XfXfLeYZb5zhLBEZP0JDIcqX038loZOc+lrOxctmIbdMSJH91lSrbLVmAI39xbmnPaqC4OscZ/KW5UF4nZrGNY9BmPMNcaY3Qc18BeMPOt+JK8E42ojKqWYg4PRJt06byIuH0Fd5BdHKAf9VzSqIpBq5/76koY2iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765393956; c=relaxed/simple;
	bh=eliJ/NhnqhHgazzmafsUKEwNtpQ2WIm4UoX+ELcUoCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSlQDsvyKNIE867nmmzmb+sRNBVhpB+7HI5JLTYXVLGEV0xoI86ortdINAUT6utWPTLK1LiJvHiRa2XZnaHQYRP9Fi9cyeiCGqvySVr2HTBoP/ya71sLDyBw7YYm+5g7F1/LaYmAYspEmSR9xhc3hgdBHEycS22CkCGmHzTN3Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XURVwJ8M; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2956d816c10so2516005ad.1
        for <linux-iio@vger.kernel.org>; Wed, 10 Dec 2025 11:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765393954; x=1765998754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Xha5K7nZqB8hFRbX65GZJTlIwsCnK6pzAo06rYcPoHM=;
        b=XURVwJ8MbNklxJ7FerhN4I0EmYdNZzPahb2JUnQU8/MZ8vf6LO9bMGgnRtVN3N1jRX
         3WRKzjbt/UDj+q7uZOGNUHqW/IxpD6U5E3/O+7FnjFLTQDvI9KVhlKRTKiXM6rzgHLOE
         xqrY4XZCHjLZIPo6vw3u/0ZzbAGzu8sdYcNAfHcDmilRqCmfyb9m35Fbi81FWIG1js4A
         3kNEa/eZVZ63AWhOeOzUVJq0cCRjz7EqLMn5p+GYtOl8fzf1pVafgjaScWIvx2QvhKOS
         ehsRo7mXcSgITJdo/xYgRrZlVftJZONNrb96f7rpeiiPBZV/dA8qwd1v+/Tlns1D14/Z
         EOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765393954; x=1765998754;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xha5K7nZqB8hFRbX65GZJTlIwsCnK6pzAo06rYcPoHM=;
        b=mO5Cz48rWCD/SXUBEg8D9QaOmRdEAlzksEfgs3lt/1RQTuBm2h9qx/mazOXhK4Q0fv
         TLYBKG9mbY59hEWtW0Pj8TDbQUVIsl3HFS0s5Kn/zlc/PrHNvN//k/IdbNYGqrEmKPvu
         1zDKG5FolCnGoRqZ+p+89wteR2jLMbPDpUwkUlXvQDpwPa3BergEmoSR1zPcvzw0Ap66
         rqb4hUU6pAiY0YS/SFgXqrQAmXLKp2+tiU8ILapbPa0twKsgwqGL+32ixoZ7vlDQGMWC
         pewDgh4cbhZOFC5MK3j3642tO51VXFJ04Ahn6USw7C7AYAdnmrgtsVi151GERo++jDai
         8X6Q==
X-Gm-Message-State: AOJu0Yx/OdDaiQeRBJ9FaGDZHViilZcfzEOsB98xs1gxM4hQc8w0RdAL
	tYvl/sVoWA8/z1tQ7BIjcE+e/ic4bbEVwIV4Bl10OFTLBk/THvr/RO24/oo8Ew==
X-Gm-Gg: AY/fxX77xd/FKF3uOtaCGyMOIs6PMg/m84DJA7HRH0y17EoytD3Q3Bcc9hsz/+iK/6w
	x/b2ie7lIfXXnr/6u0p3thQBn3KbnEoTERpXzNMrDesIGsvTnOkApf7RH83kxAahLU1ydNP9i9D
	UzE6IfxFE/9ooQ8wtRG9j5X2pOaK/p0bpLPbevQiqTgbhKI1tfRLMZSniNPOfEWf4co8Sx3niXk
	M95UFrNJCL6LcONREzs7ocOxwPOZs7PTLN27DK/Q9FYarfHqkDCqt19H48+lwJ5WLQM/ry5yE1O
	EVOY13V4KcoRri6eLZnttTDfQ0ODScX81BwNTsGO0PFV99Wu0q2XFJfKwOtDe2YOVNpyrm2O/Gz
	aLpwUX9Xht2pYlp4QEa+/HJAN0qwyIUOMaiSSha+v50kcsi9l0SSNF91+tEQRzPLjAAfFfulzg1
	P8WLoWWGSLWB3ZvgpH1g+gyqLAyQt2W1YQl34JwikGtzWmNl3rKpJdvf4VY2o=
X-Google-Smtp-Source: AGHT+IE6wuWOCBwzGjI/+VB5ipbcTFORT/fTw3YOk2aNby7qVnfS6Jq4klMDroISahAH/nDTmhNZMA==
X-Received: by 2002:a17:903:1a2b:b0:265:47:a7bd with SMTP id d9443c01a7336-29ec22c9d9amr30220665ad.4.1765393954100;
        Wed, 10 Dec 2025 11:12:34 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea016c63sm1032585ad.48.2025.12.10.11.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 11:12:33 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <17697c17-753e-46a4-8e57-107dc744f18d@roeck-us.net>
Date: Wed, 10 Dec 2025 11:12:32 -0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: lockdep splat involving iio-hwmon and iio-rescale drivers
To: Rasmus Villemoes <ravi@prevas.dk>, Peter Rosin <peda@axentia.se>,
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <87qzt2tnlu.fsf@prevas.dk>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <87qzt2tnlu.fsf@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/10/25 06:31, Rasmus Villemoes wrote:
> Hi
> 
> I have an am335x board where the AINx channels are used for various
> voltage/current measurement, i.e. they have a variety of current shunts
> and voltage dividers in front of them. Describing those is pretty
> straight-forward, and the resulting iio devices seem to work.
> 
> Now, I'd like to expose those as hwmon sensors, because there are other
> i2c-attached ADCs on the board exposed that way, and it would be nice to
> have them all available through "sensors" command in userspace. So
> altogether, my .dts additions are
> 
> 	ain {
> 		compatible = "iio-hwmon";
> 		io-channels = <&ain_12V 0>, <&ain_12V_i>, <&ain_3V3_i>, <&ain_Vin_i>, <&am335x_adc 4>;
> 	};
> 
> 	ain_12V: ain-12V {
> 		compatible = "voltage-divider";
> 		io-channels = <&am335x_adc 0>;
> 		#io-channel-cells = <1>;
> 		output-ohms = <10000>;
> 		full-ohms = <110000>;
> 	};
> 
> 	ain_12V_i: ain-12V-i {
> 		compatible = "current-sense-amplifier";
> 		io-channels = <&am335x_adc 1>;
> 		#io-channel-cells = <0>;
> 		sense-resistor-micro-ohms = <10000>;
> 		sense-gain-mult = <50>;
> 	};
> 
> 	ain_3V3_i: ain-3V3-i {
> 		compatible = "current-sense-amplifier";
> 		io-channels = <&am335x_adc 2>;
> 		#io-channel-cells = <0>;
> 		sense-resistor-micro-ohms = <10000>;
> 		sense-gain-mult = <50>;
> 	};
> 
> 	ain_Vin_i: ain-Vin-i {
> 		compatible = "current-sense-amplifier";
> 		io-channels = <&am335x_adc 3>;
> 		#io-channel-cells = <0>;
> 		sense-resistor-micro-ohms = <22000>;
> 		sense-gain-mult = <46400>;
> 		sense-gain-div = <1000>;
> 	};
> 
> [the fifth adm335x_adc channel is just to be used as-is, there's no
> circuitry in front of that].
> 
> With this, running the 'sensors' command does produce sensible output,
> but it also results in this splat:
> 
>    ============================================
>    WARNING: possible recursive locking detected
>    6.17.11 #5 Not tainted
>    --------------------------------------------
>    sensors/414 is trying to acquire lock:
>    c1dc7b68 (&iio_dev_opaque->info_exist_lock){+.+.}-{3:3}, at: iio_read_channel_raw+0x20/0x6c
>    
>    but task is already holding lock:
>    c1dd2b68 (&iio_dev_opaque->info_exist_lock){+.+.}-{3:3}, at: iio_read_channel_processed_scale+0x24/0xd8
>    
>    other info that might help us debug this:
>     Possible unsafe locking scenario:
>    
>           CPU0
>           ----
>      lock(&iio_dev_opaque->info_exist_lock);
>      lock(&iio_dev_opaque->info_exist_lock);
>    
>     *** DEADLOCK ***
>    
>     May be due to missing lock nesting notation
>    
>    4 locks held by sensors/414:
>     #0: c31fd6dc (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0x44/0x4e4
>     #1: c4f5a1c4 (&of->mutex){+.+.}-{3:3}, at: kernfs_seq_start+0x1c/0xac
>     #2: c2827548 (kn->active#34){.+.+}-{0:0}, at: kernfs_seq_start+0x30/0xac
>     #3: c1dd2b68 (&iio_dev_opaque->info_exist_lock){+.+.}-{3:3}, at: iio_read_channel_processed_scale+0x24/0xd8
>    
>    stack backtrace:
>    CPU: 0 UID: 0 PID: 414 Comm: sensors Not tainted 6.17.11 #5 NONE
>    Hardware name: Generic AM33XX (Flattened Device Tree)
>    Call trace:
>     unwind_backtrace from show_stack+0x10/0x14
>     show_stack from dump_stack_lvl+0x44/0x60
>     dump_stack_lvl from print_deadlock_bug+0x2b8/0x334
>     print_deadlock_bug from __lock_acquire+0x13a4/0x2ab0
>     __lock_acquire from lock_acquire+0xd0/0x2c0
>     lock_acquire from __mutex_lock+0xa0/0xe8c
>     __mutex_lock from mutex_lock_nested+0x1c/0x24
>     mutex_lock_nested from iio_read_channel_raw+0x20/0x6c
>     iio_read_channel_raw from rescale_read_raw+0x128/0x1c4
>     rescale_read_raw from iio_channel_read+0xe4/0xf4
>     iio_channel_read from iio_read_channel_processed_scale+0x6c/0xd8
>     iio_read_channel_processed_scale from iio_hwmon_read_val+0x68/0xbc
>     iio_hwmon_read_val from dev_attr_show+0x18/0x48
>     dev_attr_show from sysfs_kf_seq_show+0x80/0x110
>     sysfs_kf_seq_show from seq_read_iter+0xdc/0x4e4
>     seq_read_iter from vfs_read+0x238/0x2e4
>     vfs_read from ksys_read+0x6c/0xec
>     ksys_read from ret_fast_syscall+0x0/0x1c
>    Exception stack(0xe00b9fa8 to 0xe00b9ff0)
>    9fa0:                   00000000 00000000 00000003 004639f0 00001000 00000000
>    9fc0: 00000000 00000000 b6e80a7c 00000003 00000000 ffffffff 0046b1b8 bea555bc
>    9fe0: 00001000 bea54f40 00000001 b6d89e6c
> 
> Just accessing a single property under /sys/class/hwmon/hwmonX/ also
> results in a similar splat.
> 
> Am I doing things wrong, or is there a genuine problem hiding somewhere?
> 
The lock is acquired twice in the iio code, once in iio_read_channel_processed_scale()
and then again in iio_read_channel_raw(). That does look like a genuine problem to me,
but I don't know how to fix it.

Guenter


