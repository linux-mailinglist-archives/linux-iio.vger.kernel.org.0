Return-Path: <linux-iio+bounces-14731-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79630A22E51
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 14:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16852188AC38
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 13:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DBB1B87FD;
	Thu, 30 Jan 2025 13:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="nIEAFtAj"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A33C1E5708;
	Thu, 30 Jan 2025 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738245574; cv=none; b=NR7Txe+sSrtXisTJGPdllWDfgDzR0a0vzhckiBh35epGDLLciEY+DgUikedQRI9WlSwlMSTpvyXyE+EhF5mdBse07brwrfdOvoGditXYBUrFPdFsX0RbqwYLIjK65O9ysnVPgH78X+v+qB15y2FcGPVMXc/ANYUOI+SHTqKRQQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738245574; c=relaxed/simple;
	bh=tZdAwVRnQ4igyPwEBO4YSIA7EcR59sAQ2Am4iy9ll3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=px4bUxHAXTUcPiXBRZqdCNwZn2zVHWi/lVFVFF1VuP9WQE+vNMVIZLj6aUNSWBxvpbPr8Yj8yHjGY3j3327krPiE2doEa17pOGLfVDHa2App6e7M2mbazgZ+jbVDrRenYa8vpJVyd2obAJteO7dgD2yreo0swJO0+XOUEGRyVZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=nIEAFtAj; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 985E7A0472;
	Thu, 30 Jan 2025 14:59:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=M8qq1IPzgBd/vMLJUXF0
	AzXwyZ9z/lMINXwf8wvq/cU=; b=nIEAFtAj+A4yA5OmrTiy4fPGRifiC41xrudj
	1cssfFbbIGlpnBoGWIWHI+0Iu5hEFHl0al20J20PjvANxpho8DPv+XGQdJldHu4G
	SpUvn6jbUz8aIme7kdQrBKDg9ml2BEFr7QoEZg1NXstmiTA6Paq9aFx56bgE7WXN
	TjJgwGfUpJJEZaTBmP6J7dvcCmIkZ6GYcPHk64T7b3eKHptuRyWaAemDG9YFIlFi
	3dGGSevBFSx1HVrnDKH4v/5T6jsy4MIDldWpok54fHfNw5Dp0BV/+2/otBZkxsju
	BRP7lOpLazzHzzwZAMsdI1vg9TJLQ8BavQQgj0OUUrmHOGO+0cy++5CFjptpc1Pb
	vKDPA8J+f6EbC4aC5nJuD1NuHGPfvx9y8llgaZE/U2VLhT270mbfWGbEO0NFhGhJ
	VKX9ktDNEHA6a8Da7U1HkQGLhXRSj3BiBpITvdqC4/TtMg1kFxsssfNAmmnoj8nN
	z9n+mrrzrjWRa+4fU0gHyofBowiyAnOIAOeOWfsHdSXeBgFpr4/3jjObkTEGbyt5
	ywg4iEWqRca8PMWlXAvXj+lQhh7xtvwd2M0fH1gSR66IePitBXKBPletkT1Ni45a
	rOIWCA0D42tXF9n7gvEhLEx+1yIWdD01gy7BIiR3tyODKpBHFearVt2s+ItZPbYb
	cd+DDVA=
Message-ID: <dffc0f18-799a-4fc7-a6b5-2fa270e1fc58@prolan.hu>
Date: Thu, 30 Jan 2025 14:59:20 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Q] Frequency & duty cycle measurement?
To: William Breathitt Gray <wbg@kernel.org>
CC: <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<timestamp@lists.linux.dev>, Jonathan Cameron <jic23@kernel.org>, "Lars-Peter
 Clausen" <lars@metafoo.de>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Thomas Gleixner" <tglx@linutronix.de>, Dipen Patel <dipenp@nvidia.com>,
	<dlechner@baylibre.com>
References: <f2ec8a55-42ad-498a-b793-072444dcb92e@prolan.hu>
 <Z5efcokgHix-k3lW@ishi>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <Z5efcokgHix-k3lW@ishi>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852667467

Hi William,

On 2025. 01. 27. 16:00, William Breathitt Gray wrote:
> In the userspace application, you would setup a Counter "watch" to
> collect each desired timer value on the respective Counter events; I
> assume RA and RB are Count 0 and Count 1 respectively, but if they
> represent something else please let me know:
> 
>      static struct counter_watch watches[2] = {
>              {
>                      /* Component data: Count 0 count */
>                      .component.type = COUNTER_COMPONENT_COUNT,
>                      .component.scope = COUNTER_SCOPE_COUNT,
>                      .component.parent = 0,
>                      /* Event type: Capture */
>                      .event = COUNTER_EVENT_CAPTURE,
>                      /* Device event channel 0 */
>                      .channel = 0,
>              },
>              {
>                      /* Component data: Count 1 count */
>                      .component.type = COUNTER_COMPONENT_COUNT,
>                      .component.scope = COUNTER_SCOPE_COUNT,
>                      .component.parent = 1,
>                      /* Event type: Capture */
>                      .event = COUNTER_EVENT_CAPTURE,
>                      /* Device event channel 0 */
>                      .channel = 0,
>              },
>      };
>      ...
>      int main(void)
>      {
>              int fd;
>              int i;
> 	    unsigned long long delta_ts, delta_ra, delta_rb;
> 	    double ra_frequency, rb_frequency, rb_ra;
>              struct counter_event first_capture[2], second_capture[2];
>              
>              /* Open Counter chrdev */
>              fd = open("/dev/counter0", O_RDWR);
>              
>              for (i = 0; i < 2; i++) {
> 	            /* Register all Counter watches */
>                      ioctl(fd, COUNTER_ADD_WATCH_IOCTL, watches + i);
>              }
> 	    /* Start collecting Counter events */
>              ioctl(fd, COUNTER_ENABLE_EVENTS_IOCTL);
>              
>              for (;;) {
> 	        /* Read first Counter event capture */
>              	read(fd, first_capture, sizeof(first_capture));
> 	        /* Read second Counter event capture */
>              	read(fd, second_capture, sizeof(second_capture));
>                  
> 		/* Within each capture, timestamp is the same so only
> 		 * first element of each capture needs to be compared */
> 		delta_ts = second_capture[0].timestamp - first_capture[0].timestamp;
> 		/* Compute deltas of timer register pair RA and RB.
> 		delta_ra = second_capture[0].value - first_capture[0].value;
> 		delta_rb = second_capture[1].value - first_capture[1].value;
>                  
> 		ra_frequency = (double)delta_ra / delta_ts;
> 		rb_frequency = (double)delta_rb / delta_ts;
> 		rb_ra = (double)delta_rb / delta_ra;
>                  
>              	printf("RA frequency: %ld\n"
> 		       "RB frequency: %ld\n"
> 		       "RB per RA: %ld\n"
>              	       ra_frequency, rb_frequency, rb_ra);
>              }
>              
>              return 0;
>      }
> 
> If RA and RB are provided as a memory buffer on your device, you can
> instead expose them via DEFINE_COUNTER_ARRAY_CAPTURE() such as the
> ti-ecap-capture driver does, then perform your userspace computations
> by utilizing those respective "capture" array attribute values (via
> chrdev like the example above or alternatively via sysfs).

Thanks for your extensive explanation! With 
DEFINE_COUNTER_ARRAY_CAPTURE() I was able to expose RA and RB as 
`/sys/bus/counter/devices/counter0/count0/capture{0,1}`, and could 
verify that by replacing `devmem` calls with read()-reopen(), our PoC 
code still works. Now I want to use the chardev interface, but I 
couldn't find how to set up the watches appropriately. So far I have:

	{
		.component.type = COUNTER_COMPONENT_EXTENSION,
		// also tried COUNTER_COMPONENT_COUNT
		.component.scope = COUNTER_SCOPE_COUNT,
		.component.parent = 0,
		.component.id = X, // also tried this instead:
		// .channel = X,
		.event = COUNTER_EVENT_CAPTURE,
	},

However, with this, the first read() never comes back.

Bence


