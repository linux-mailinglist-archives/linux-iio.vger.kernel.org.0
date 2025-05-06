Return-Path: <linux-iio+bounces-19205-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B36C3AACC03
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 19:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56055507161
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 17:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DB42857E1;
	Tue,  6 May 2025 17:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zn6SuYO2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A112836A4
	for <linux-iio@vger.kernel.org>; Tue,  6 May 2025 17:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746551515; cv=none; b=oapeBQmhPMR2jFaHfgmwcaq9E7tHGv+47ET51PmIVi8cJteO3mZ/0AOmUpFjc1ASPBRMPlQwqe940Xm3xIhx3rybHvxy3BRBQ8khtjTNZz/yuxmJHthju5wKnIuo3opl/QgLsrjCrLvr2SfudAOKo8LuamQun0TcKnlwA4+3ky0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746551515; c=relaxed/simple;
	bh=siIncqwNtWC6Cffe/UEzd4HGNlJ47tlCSk/EUKqczLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m2/xLdksRDVVmpPV3oztzPBn/GsRJis2oqyJxLH8FcNW18ljz7Q1TYNZ0t3BT0x8kG4rHoySVkWCsCxjDCqqDazsUp65288eBWJBgfWh6D6C83xCYnqA7BA7coHd73Y0E+Wa0JCULY8X0NV0gNguDkFrP4fYIZ2e+pOXSpg1NoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zn6SuYO2; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2c2bb447e5eso3399695fac.0
        for <linux-iio@vger.kernel.org>; Tue, 06 May 2025 10:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746551512; x=1747156312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2JbcRvp94rGDw5RQs6ZrHCsYm6m5bJbU/CjzQthhb4w=;
        b=zn6SuYO25KPxYG7NvgFfHGAAy8u0YzIda67oylCmmgGmHc7VTYFjCsMchWMeA0ggMS
         aUzPClkzoId63tqud7CwrvzZeGw5T09zQOWTTaOkI9UbCjfA3o6uT65GqZ/y1eZRLbSL
         cUzovXjFtsuwWvtDo+M/bireKAoc/GMtvT02UwRowtxIoWiCVePDfvFYINvIFsXmWdq4
         p1LwsrW6TPC1GJ5nzt2uWlJPZ4DNjoW6VZhLvH/3ITAazcgI2HIOzZxrqV51cuLtyB4r
         YiptKMU9729MS2GpxMgXx+tCCINN2B9ik4CCQ7m7VskBCTkw17ZDqJr5dtmJiB2n5vPz
         sRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746551512; x=1747156312;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2JbcRvp94rGDw5RQs6ZrHCsYm6m5bJbU/CjzQthhb4w=;
        b=jwt4TsR1K0Z0ujTruv+qy7/9qysViHm48wvafqVfFE6/EbXz1/SFrXbT1XAR03caG7
         er3kkYGfU+KFPAyn5GcMubv2/cuUEwdIY+oWhgx9bFr+rB02GgmKI2vzDvAc+h1CB8pu
         UwJkPeLslMIcsQi86IprCDRm3iJuvO4mowv2N5elhv3YU3DqgvrpY+PzHXRc9EThf3wH
         tYqi4H1Lyz8bPFZDNBeNN5KILCMjsfKKN02Flt2FbZeSEgUhrCzinkjWXqnhpHT7rmv2
         Ew3ppJT8s54I7dSztiiJgaHkryDyMvViMqTMTekgZfe0y0kNNowp9lWMtnWbfSK2EWTV
         y/NA==
X-Forwarded-Encrypted: i=1; AJvYcCUZgdC5QDpDLa6GO+A1wmbVf270wXA91AlbrB/WY+LovS3wCCt4x519sYbOLV0kIhzhEt1eTVc9sBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTqbdB15Rm/F9RQhPn3gCVOfCzktXOyKLz3gKeSvMjuQCf++yH
	bja5krdCJUOq6FDzyqfnMbZANpqv5spYNhrokOA567QgUkL/OAnq5VI0imeDjhI=
X-Gm-Gg: ASbGncuNDesvEIWFwopN8oy3foXTY2p/jZAo3CjWL1io0zp/H0CxjlraDkOXO47cKeW
	BsTs5tGbxcIMgzalIL+TvFMP3kwdk/crx5rCNfYPjl9cP3Xez+dlzMASbIyLS/NUVADLdEnVKI8
	KLPnwb8dQ5YvuUnt4IcuiJa/X6Y+B/kbtTJvdI+Yn0s+ThiY3MPYRIj7zf2tOYY2QoJcb+9re7k
	w3iALZxjlI4o5iz3s6pBXEzcR1idtOVeUD0rVOJA1U+GSW0zQN7PC8Z4lsiVz8VTgEyUEDlEDK0
	pUwo54lP9BN5LUf90rN/c85lRbonAugaVwgs48sxDy0x8tRvF8NzhHXWn6qxtzW9/PnfA+gTOwK
	de65gCLLXM1NM9pmSd82gpdoKEvN6
X-Google-Smtp-Source: AGHT+IGgVYJkjCCePqTNI6WyvbdrY2fuOkGm/ofTVtIR4HS2aq9wiljx2SuAeNHIIKo4f+OLxkBFFw==
X-Received: by 2002:a05:6870:4692:b0:2da:7e06:ed8e with SMTP id 586e51a60fabf-2db5bd83d78mr59453fac.4.1746551512329;
        Tue, 06 May 2025 10:11:52 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:5172:9f6c:997a:41ea? ([2600:8803:e7e4:1d00:5172:9f6c:997a:41ea])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2daa126b848sm2816041fac.48.2025.05.06.10.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 10:11:51 -0700 (PDT)
Message-ID: <d0353f6c-8bab-4178-8bed-0ad6157fe351@baylibre.com>
Date: Tue, 6 May 2025 12:11:51 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: sensor-hub: Fix typo and improve documentation
To: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>, jikos@kernel.org,
 bentiss@kernel.org, jic23@kernel.org, srinivas.pandruvada@linux.intel.com
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250506163523.3262037-1-chelsyratnawat2001@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250506163523.3262037-1-chelsyratnawat2001@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/25 11:35 AM, Chelsy Ratnawat wrote:
> Includes the following corrections -
>  - Changed Measurment -> Measurement
>  - Changed clode -> close
>  - Gyro -> gyro
> 
> Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
> ---
>  include/linux/hid-sensor-hub.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
> index 0f9f7df865db..3621d35a00d6 100644
> --- a/include/linux/hid-sensor-hub.h
> +++ b/include/linux/hid-sensor-hub.h
> @@ -17,7 +17,7 @@
>   * @attrib_id:		Attribute id for this attribute.
>   * @report_id:		Report id in which this information resides.
>   * @index:		Field index in the report.
> - * @units:		Measurment unit for this attribute.
> + * @units:		Measurement unit for this attribute.
>   * @unit_expo:		Exponent used in the data.
>   * @size:		Size in bytes for data size.
>   * @logical_minimum:	Logical minimum value for this attribute.
> @@ -39,8 +39,8 @@ struct hid_sensor_hub_attribute_info {
>   * struct sensor_hub_pending - Synchronous read pending information
>   * @status:		Pending status true/false.
>   * @ready:		Completion synchronization data.
> - * @usage_id:		Usage id for physical device, E.g. Gyro usage id.
> - * @attr_usage_id:	Usage Id of a field, E.g. X-AXIS for a gyro.
> + * @usage_id:		Usage id for physical device, e.g. gyro usage id.
> + * @attr_usage_id:	Usage Id of a field, e.g. X-AXIS for a gyro.

I don't think "axis" needs to be all caps either. This is a numeric fields, so
it's not like this is a string literal and there is a dash in the name so I
don't think the intention was to reference a macro name.

>   * @raw_size:		Response size for a read request.
>   * @raw_data:		Place holder for received response.
>   */
> @@ -104,10 +104,10 @@ struct hid_sensor_hub_callbacks {
>  int sensor_hub_device_open(struct hid_sensor_hub_device *hsdev);
>  
>  /**
> -* sensor_hub_device_clode() - Close hub device
> +* sensor_hub_device_close() - Close hub device
>  * @hsdev:	Hub device instance.
>  *
> -* Used to clode hid device for sensor hub.
> +* Used to close hid device for sensor hub.
>  */
>  void sensor_hub_device_close(struct hid_sensor_hub_device *hsdev);
>  


