Return-Path: <linux-iio+bounces-24096-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E32D1B56A45
	for <lists+linux-iio@lfdr.de>; Sun, 14 Sep 2025 17:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C12D3BC110
	for <lists+linux-iio@lfdr.de>; Sun, 14 Sep 2025 15:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED622DA767;
	Sun, 14 Sep 2025 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="l/g9KF8Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19BC2D12F1
	for <linux-iio@vger.kernel.org>; Sun, 14 Sep 2025 15:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757864570; cv=none; b=NxTx7943tZ1JRGyjjOm3AbrPMNGWXHhZ75ViLsG58q/ixHKoDx5Ik8JhMgYBX7kKmyxCtqAZzJLL2l+LihlxN/CUlAZ/Vhan/HNgvQNLaVUbSrcZ52LlNgrV4ETlsgLD2SrHwghIbHbhMNI+gExhHdn6b16OS8L0tiaR1ZhPk9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757864570; c=relaxed/simple;
	bh=2kTO7fSnhMVyK+qYKRpBlWVwUbkQabm7L4Mhbd3GzUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OYdqaXf5iYsm85CWDK+w7n6IMcmYTLGJaKY+TXBbQ/Ta+KlHsLfKyzCW6rP72pEfRn1KfB+CedkFP/DM7aoMW2YXIM8pkf+ODR7gNEMGmn8C+zGvDqGdNzemEUgRjPGRV0q4JSwYpx+oYDzqPPzg4aSd8BI3rI6hKsQio5lGs5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=l/g9KF8Q; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3e7622483beso1667975f8f.3
        for <linux-iio@vger.kernel.org>; Sun, 14 Sep 2025 08:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1757864566; x=1758469366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lF7TefPrj8nTqh1Zwwwayl7uZBox7tbKj5sj7DEzwK4=;
        b=l/g9KF8QnqhdqAoEkVzcH1WJF3Y3CW7ZQ7735QkqJW4I5f66Agp87z+L4ML/thusA6
         vQ46bzcz8/6SeJDSE+yNwXVVHTNa4bkOjersD22uQpqEMmgUjePDFKWsTV1YzchmDQ88
         8WCNlM4gdKX4b6dqbEudtkxouOBXbWDr09RjCY8/ucgijh5tNGmJx9LpKwdUangQbkWc
         2fD4zHQp6bjKmYp3/C/jrfOF5wIePJ3PdgB/0X60GLOKdcoIiYVuucGFR1Wx04bvJBBJ
         lUpwm05OD3Fn8sAjvxDKFl88d7GoT09QuQp8n/Ewix587A/sNjm7HNs8yZVHQbx8AK6G
         31ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757864566; x=1758469366;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lF7TefPrj8nTqh1Zwwwayl7uZBox7tbKj5sj7DEzwK4=;
        b=ukqfaZXNJAYPDzyP4LbQbVNm6zvy3ODGwXRamXpzFukayeB/DBBEHpw2C9ZgVTvz69
         VwpndGAEopXE7BBNhQl3O/uQZf5Y3C101sh/GDVe4kzdyyD76jLffsPxE/B9WpaziWh+
         QuVYq/03HBVL0G5ENNOUFC+xGYZrqVAYAbfzqpCL1mM6w3ycR0WaQWC7L3IfSKLMy1ZU
         9c/3/aMgCZuGImLUHzkWDUFUgoVgMF/iFFNbMmhG8LLB0/kOyFOhDz7qakir0xOLVaYn
         puAeF3g0Lyf0SLsrVvPAdZORICbPXpm1cJ4LkZXYgzTm/JzEgjpRKFDGxAORb53MZ/Dm
         ElNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDTL/GQSclooePAcs7Po3A+xbnhwuCIVGGFqScXdWWBpOmsY7h+oC1zecd9q7yyx35yTvESdlIUDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVPAmoJi3mN+j+ZNouqz3YYeBY8X7+eskTRQl9lycKcVAP/dMa
	MYAD15+OvQXElN7VZMmyYrcXUWtqrZpxyZCRm1JvUX3x9fpXj1U21UcmRhbxshml5d0=
X-Gm-Gg: ASbGnctJStIkFbfoYpcANWqWYROXthIoDHoDBKrQv4uIhOo53f5thoyGcVWlfjKmHy0
	ATekZ4UOvyWOWAKW8ASLixe6obbvl2gZuEvBQEoiZkMp1ecS5kZ57XVj79vuSMUH+ZLEez4ci/K
	dDMlkhuvd+UbkeIK2qZtM8qwxSkG94COAnA8xoY/63BYBA5siqRa2v0g+nMFTOQjbFFQZKLDmAV
	fIc50VB7I8yHTlvlcHJPvNBZIFjwNk67DyJxA1ZtCgxpj9/MXxJhzltLHMVuXl2g3gehA5oWM1g
	vb6u/Sn+6o8xu5xdK6VyGIIX6jixQ7L6nU5JZXir50pLGkmHncntaSadAf2EvWn/z683AnGp4J4
	M+7zfBuHIUlcpkWYGFNtD1YZTH+TRn0Xm9oGXRexI/Q==
X-Google-Smtp-Source: AGHT+IFzwsBtZqrEsafWUsUxi583ZTfa92WFIWs6GNlc6Hk5flYFXVJ+chnYflQbOkJeB1ew0UPusg==
X-Received: by 2002:a5d:5d05:0:b0:3e4:f194:2886 with SMTP id ffacd0b85a97d-3e7657b9d92mr7371826f8f.19.1757864565702;
        Sun, 14 Sep 2025 08:42:45 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e8237cfdddsm7414702f8f.60.2025.09.14.08.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Sep 2025 08:42:45 -0700 (PDT)
Message-ID: <3a3a3e2c-2156-40bb-9233-fc2e6320eaa6@tuxon.dev>
Date: Sun, 14 Sep 2025 18:42:43 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] nvmem: microchip-otpc: rework to access packets
 based on tag
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 eugen.hristev@linaro.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, srini@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250804100219.63325-1-varshini.rajendran@microchip.com>
 <20250804100219.63325-3-varshini.rajendran@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250804100219.63325-3-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Varshini,

On 8/4/25 13:02, Varshini Rajendran wrote:
> Rework the driver to change the packet access technique based on the TAG
> instead of the currently in use "id".
> 
> Since there is no way of knowing the OTP memory mapping in advance or the
> changes it can go through with time, the id based approach is not reliable.
> Accessing the packets based on the associated tags is a fail-proof
> approach. This method is aided by adding a table of contents to store the
> payload information which makes it easier to traverse through the OTP
> memory and read the data of the intended packet. The stride of the nvmem
> device is adjusted to 1 to support the TAG being treated as an offset.
> The only reliable way to recognize a packet without being aware of the
> flashed contents of the OTP memory is the TAG of the packet.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  drivers/nvmem/microchip-otpc.c | 130 +++++++++++++++++++++++++--------
>  1 file changed, 101 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
> index df979e8549fd..e922c882af72 100644
> --- a/drivers/nvmem/microchip-otpc.c
> +++ b/drivers/nvmem/microchip-otpc.c
> @@ -18,16 +18,27 @@
>  #define MCHP_OTPC_CR_READ		BIT(6)
>  #define MCHP_OTPC_MR			(0x4)
>  #define MCHP_OTPC_MR_ADDR		GENMASK(31, 16)
> +#define MCHP_OTPC_MR_EMUL		BIT(7)
>  #define MCHP_OTPC_AR			(0x8)
>  #define MCHP_OTPC_SR			(0xc)
>  #define MCHP_OTPC_SR_READ		BIT(6)
>  #define MCHP_OTPC_HR			(0x20)
>  #define MCHP_OTPC_HR_SIZE		GENMASK(15, 8)
> +#define MCHP_OTPC_HR_PACKET_TYPE	GENMASK(2, 0)
>  #define MCHP_OTPC_DR			(0x24)
>  
>  #define MCHP_OTPC_NAME			"mchp-otpc"
>  #define MCHP_OTPC_SIZE			(11 * 1024)
>  
> +enum packet_type {
> +	PACKET_TYPE_REGULAR = 1,
> +	PACKET_TYPE_KEY	= 2,
> +	PACKET_TYPE_BOOT_CONFIG = 3,
> +	PACKET_TYPE_SECURE_BOOT_CONFIG = 4,
> +	PACKET_TYPE_HARDWARE_CONFIG = 5,
> +	PACKET_TYPE_CUSTOM = 6,

You can drop unused packet types.

> +};
> +
>  /**
>   * struct mchp_otpc - OTPC private data structure
>   * @base: base address
> @@ -42,6 +53,25 @@ struct mchp_otpc {
>  	u32 npackets;
>  };
>  
> +/**
> + * struct mchp_otpc_payload_info - OTP packet's payload information
> + *				retrieved from the packet's header
> + * @id: driver assigned packet ID
> + * @packet_offset: offset address of the packet to be written in the
> + *			register OTPC_MR.ADDR to access the packet
> + * @payload_length: length of the packet's payload
> + * @packet_type: type of the packet
> + * @packet_tag: TAG corresponding to the packet. Applicable for most
> + *		of the regular packets
> + */
> +struct mchp_otpc_payload_info {
> +	u32 id;
> +	u32 packet_offset;

Can you keep packet specific members in struct mchp_otpc_packet?

> +	u32 payload_length;
> +	u32 packet_type;
> +	u32 packet_tag;

Will this technique limit the number of packets that can be in memory? I
think this is not an issue with the current devices? What about the upcomming?

> +};
> +
>  /**
>   * struct mchp_otpc_packet - OTPC packet data structure
>   * @list: list head
> @@ -50,20 +80,16 @@ struct mchp_otpc {
>   */
>  struct mchp_otpc_packet {
>  	struct list_head list;
> -	u32 id;
> -	u32 offset;
> +	struct mchp_otpc_payload_info payload_info;

Warning: ../drivers/nvmem/microchip-otpc.c:83 struct member 'payload_info'
not described in 'mchp_otpc_packet'

>  };
>  
> -static struct mchp_otpc_packet *mchp_otpc_id_to_packet(struct mchp_otpc *otpc,
> -						       u32 id)
> +static struct mchp_otpc_packet *mchp_otpc_tag_to_packet(struct mchp_otpc *otpc,
> +							u32 tag)
>  {
>  	struct mchp_otpc_packet *packet;
>  
> -	if (id >= otpc->npackets)
> -		return NULL;
> -
>  	list_for_each_entry(packet, &otpc->packets, list) {
> -		if (packet->id == id)
> +		if (packet->payload_info.packet_tag == tag)
>  			return packet;
>  	}
>  
> @@ -140,8 +166,27 @@ static int mchp_otpc_prepare_read(struct mchp_otpc *otpc,
>   * offset returned by hardware.
>   *
>   * For this, the read function will return the first requested bytes in the
> - * packet. The user will have to be aware of the memory footprint before doing
> - * the read request.
> + * packet. The user won't have to be aware of the memory footprint before doing
> + * the read request since it is abstracted and taken care by this driver.
> + *
> + * There is no way of knowing the Mapping of the OTP memory table in advance. In
> + * this read function the offset requested is treated as the identifier string
> + * i.e., Packet TAG, to acquire the payload with reliability. The packet Tag
> + * is the only way to recognize a packet without being aware of the flashed
> + * OTP memory map table.
> + */
> +
> +/**
> + * mchp_otpc_read() - Read the OTP packets and fill the buffer based on the TAG
> + *		      of the packet treated as the offset.
> + * @priv: Pointer to device structure.
> + * @off: offset of the OTP packet to be read. In this case, the TAG of the
> + *	 corresponding packet.
> + * @val: Pointer to data buffer
> + * @bytes: length of the buffer
> + *
> + * A value of zero will be returned on success, a negative errno will be
> + * returned in error cases.
>   */
>  static int mchp_otpc_read(void *priv, unsigned int off, void *val,
>  			  size_t bytes)
> @@ -154,30 +199,23 @@ static int mchp_otpc_read(void *priv, unsigned int off, void *val,
>  	int ret, payload_size;
>  
>  	/*
> -	 * We reach this point with off being multiple of stride = 4 to
> -	 * be able to cross the subsystem. Inside the driver we use continuous
> -	 * unsigned integer numbers for packet id, thus divide off by 4
> -	 * before passing it to mchp_otpc_id_to_packet().
> +	 * From this point the packet tag received as the offset has to be translated
> +	 * into the actual packet. For this we traverse the table of contents stored
> +	 * in a list "packet" and look for the tag.
>  	 */
> -	packet = mchp_otpc_id_to_packet(otpc, off / 4);
> +
> +	packet = mchp_otpc_tag_to_packet(otpc, off);
>  	if (!packet)
>  		return -EINVAL;

If one would want to read the full content of the memory will this function
return first time offset will not corresond to a valid packet?

> -	offset = packet->offset;
> +	offset = packet->payload_info.packet_offset;
>  
> -	while (len < bytes) {
> +	if (len < bytes) {

The approach now is that a single packet can be read at a moment, right? Is
this intended?

>  		ret = mchp_otpc_prepare_read(otpc, offset);
>  		if (ret)
>  			return ret;
>  
> -		/* Read and save header content. */
> -		*buf++ = readl_relaxed(otpc->base + MCHP_OTPC_HR);
> -		len += sizeof(*buf);
> -		offset++;
> -		if (len >= bytes)
> -			break;
> -

Dropping this will not return the header content anymore. Is this intended?

>  		/* Read and save payload content. */
> -		payload_size = FIELD_GET(MCHP_OTPC_HR_SIZE, *(buf - 1));
> +		payload_size = packet->payload_info.payload_length;
>  		writel_relaxed(0UL, otpc->base + MCHP_OTPC_AR);
>  		do {
>  			*buf++ = readl_relaxed(otpc->base + MCHP_OTPC_DR);
> @@ -190,6 +228,20 @@ static int mchp_otpc_read(void *priv, unsigned int off, void *val,
>  	return 0;
>  }
>  
> +static int mchp_otpc_read_packet_tag(struct mchp_otpc *otpc, unsigned int offset, unsigned int *val)

This exceeed 100 chars.

> +{
> +	int ret;
> +
> +	ret = mchp_otpc_prepare_read(otpc, offset);
> +	if (ret)
> +		return ret;
> +
> +	writel_relaxed(0UL, otpc->base + MCHP_OTPC_AR);
> +	*val = readl_relaxed(otpc->base + MCHP_OTPC_DR);
> +
> +	return 0;
> +}
> +
>  static int mchp_otpc_init_packets_list(struct mchp_otpc *otpc, u32 *size)
>  {
>  	struct mchp_otpc_packet *packet;
> @@ -213,8 +265,15 @@ static int mchp_otpc_init_packets_list(struct mchp_otpc *otpc, u32 *size)
>  		if (!packet)
>  			return -ENOMEM;
>  
> -		packet->id = id++;
> -		packet->offset = word_pos;
> +		packet->payload_info.id = id++;
> +		packet->payload_info.packet_offset = word_pos;
> +		packet->payload_info.payload_length = payload_size;
> +		packet->payload_info.packet_type = FIELD_GET(MCHP_OTPC_HR_PACKET_TYPE, word);
> +
> +		if (packet->payload_info.packet_type == PACKET_TYPE_REGULAR)
> +			ret = mchp_otpc_read_packet_tag(otpc, packet->payload_info.packet_offset,
> +							&packet->payload_info.packet_tag);
> +
>  		INIT_LIST_HEAD(&packet->list);
>  		list_add_tail(&packet->list, &otpc->packets);
>  
> @@ -236,7 +295,7 @@ static struct nvmem_config mchp_nvmem_config = {
>  	.type = NVMEM_TYPE_OTP,
>  	.read_only = true,
>  	.word_size = 4,
> -	.stride = 4,
> +	.stride = 1,
>  	.reg_read = mchp_otpc_read,
>  };
>  
> @@ -244,8 +303,9 @@ static int mchp_otpc_probe(struct platform_device *pdev)
>  {
>  	struct nvmem_device *nvmem;
>  	struct mchp_otpc *otpc;
> -	u32 size;
> +	u32 size, tmp;
>  	int ret;
> +	bool emul_enable;
>  
>  	otpc = devm_kzalloc(&pdev->dev, sizeof(*otpc), GFP_KERNEL);
>  	if (!otpc)
> @@ -256,10 +316,22 @@ static int mchp_otpc_probe(struct platform_device *pdev)
>  		return PTR_ERR(otpc->base);
>  
>  	otpc->dev = &pdev->dev;
> +
> +	tmp = readl_relaxed(otpc->base + MCHP_OTPC_MR);
> +	emul_enable = tmp & MCHP_OTPC_MR_EMUL;
> +	if (emul_enable)
> +		dev_info(otpc->dev, "Emulation mode enabled\n");

Can you update the commit with the meaning of these?

> +
>  	ret = mchp_otpc_init_packets_list(otpc, &size);
>  	if (ret)
>  		return ret;
>  
> +	if (size == 0) {
> +		dev_err(otpc->dev, "Cannot access OTP memory !\n");

Space before !

> +		if (!emul_enable)
> +			dev_err(otpc->dev, "Boot packet not configured & Emulation mode not enabled !\n");

Do you still want to register the driver in case size == 0?

Thank you,
Claudiu

> +	}
> +
>  	mchp_nvmem_config.dev = otpc->dev;
>  	mchp_nvmem_config.add_legacy_fixed_of_cells = true;
>  	mchp_nvmem_config.size = size;


