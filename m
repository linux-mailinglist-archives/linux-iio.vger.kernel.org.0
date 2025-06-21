Return-Path: <linux-iio+bounces-20824-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E516EAE2AD4
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 19:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490253A8019
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 17:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20842676E9;
	Sat, 21 Jun 2025 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RY2fN0xg";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="se0gDlsr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11E5221FB2;
	Sat, 21 Jun 2025 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750527230; cv=none; b=MSteTAqvDq60hd0DsIdRuBsj/kJdOpAay61jvN7S/I7u/cYqIVIiab8QScavjTU6oCCVvxFO6jrtPcXHuqJT1ihokl+ZcTLI8QfqqdZClD8pGYufJKfIC594El+H6FNrGApTDB8rj0CX034zdHTuBZ6OnMOcARVssOePTNBacig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750527230; c=relaxed/simple;
	bh=Uhepke83ShIIDnMX++9PzSVwwbKI4JggFSJJLHQqcNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OUPziepTFlp21wMN4BWnHJ8kpZLekUruW5r9rWFU+T+OREo9BQBZkkITaTcQ6I8h/wE1EnAclxhHL3zSSJOthyurdbsIBFeBn9HkeUC2ZHsSdJjSYwKimnPDU28hdh0efgjZHkTKYaJTVkbQMTdPAtn+L0vvmIgP4ZZof7a6k3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=RY2fN0xg; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=se0gDlsr; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bPhK65tZMz9shk;
	Sat, 21 Jun 2025 19:33:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750527226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hKlZ1V8bNRaeQqIAJu2/xBfWQBgG8jQ8bF3M9fEaflU=;
	b=RY2fN0xgO1Uq+NAHehur9uKhMy9i+TPJcI5ar0xAr3K91VjsNyL65S9dJrd+ugpqmPs1CE
	C5mB2u6fyVq0sqI5RIS4kOHDpVWYtqa9kw1S68PYFV322iXu+OqbM+KcraJUmDDDt4Rt9d
	w1Y43pRvnJfef62K/0tE8r6CZIYxG+6QOcahwRIIcW4E21XXjzNK/0xDXDH+COwOxpC8eP
	/29nQAOAPh9eAXYvY7XqL8izNISCdTlbn1xWIg07lOzu8bTRVOj9chhx3OvjSEr6Zac6+9
	32uQpVdRn116aoEHHUZ4eYmaxUb5rwXWsGa8tnXEQ6Ps2COBTV0ThPifgnwgWQ==
Message-ID: <3e7daf0d-6472-4e53-86eb-e5c5c1fd3640@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750527224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hKlZ1V8bNRaeQqIAJu2/xBfWQBgG8jQ8bF3M9fEaflU=;
	b=se0gDlsr3dGTPbu8Er5Ifv3bZjZ1KmWmNO2Wm5LqmRzNZQjeKeujbfleI0BMPonPMSuJnI
	mDhr3p+mWktToK6MhtoVAcVk3bejVIy57+EEIco1fX0hJoqdROtDsR0OlCo1jlV5nEBnFG
	1LeCHd2L4XPD1zXyMhJp83H+7LhE1s/zekSi9+QC/1qvOTYmdjl0BHilHOsHG6dyoYxSzB
	hwEHFLh8Oq9j7B8Z9b0NUnFuSbL27kKvPBqZDZLJMy8Ro/zAw9ScAHbKQTyQ3WBezqNjqO
	GnBC5uxW7ZBZONeJI5eVsqkmJ5AeUZg0bwVz9j8tLylZ+BzeCKe0QDeLcJpuVA==
Date: Sat, 21 Jun 2025 19:33:41 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] iio: accel: bmc150: Do not configure IRQ registers if no
 IRQ connected
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Marek Vasut <marek.vasut+bmc150@mailbox.org>,
 Hans de Goede <hansg@kernel.org>, linux-iio@vger.kernel.org,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, Julien Stephan <jstephan@baylibre.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Salvatore Bonaccorso <carnil@debian.org>, linux-kernel@vger.kernel.org
References: <20250613124648.14141-1-marek.vasut+bmc150@mailbox.org>
 <aEw_DcqpCpcsBGd0@smile.fi.intel.com>
 <8605141c-b615-4e84-9574-81e24590df48@mailbox.org>
 <aE_aL5dGKZeKBu50@smile.fi.intel.com>
 <db14331e-193a-4915-990e-7657b5ca0c5b@mailbox.org>
 <CAHp75VcZ6-WFyyERg7YVXNj3-uggwyNf2fF4mnbhiUZ6xNwYvg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAHp75VcZ6-WFyyERg7YVXNj3-uggwyNf2fF4mnbhiUZ6xNwYvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: bmnfz4qt7cc5rp99epf6fgzpqko5yqud
X-MBO-RS-ID: c1890073db4bb1109aa

On 6/16/25 1:09 PM, Andy Shevchenko wrote:

Hi,

>>> You can try to monitor the /sys/kernel/debug/pinctrl/*/pins files for any
>>> changes that might happen on the sensor events. It might (help to) reveal
>>> the IRQ line.
>> Sooo ... if the IRQ line is not described in ACPI, it could still be
>> connected ? Hum, I'll try to shake the laptop next time I power it up.
> 
> Yes, it's possible, unfortunately due to the closed / per-product
> nature of the Windows drivers.

This is the only pins I got out of this, and there doesn't seem to be 
anything changing if I shake the machine:

# cat /sys/kernel/debug/pinctrl/INT344B\:00/pins
registered pins: 152
pin 0 (RCINB) 0:INT344B:00 GPIO 0x04000102 0x00001018
pin 1 (LAD_0) 1:INT344B:00 mode 1 0x44000702 0x00003c19 [ACPI]
pin 2 (LAD_1) 2:INT344B:00 mode 1 0x44000702 0x00003c1a [ACPI]
pin 3 (LAD_2) 3:INT344B:00 mode 1 0x44000702 0x00003c1b [ACPI]
pin 4 (LAD_3) 4:INT344B:00 mode 1 0x44000702 0x00003c1c [ACPI]
pin 5 (LFRAMEB) 5:INT344B:00 mode 1 0x44000700 0x0000001d [ACPI]
pin 6 (SERIQ) 6:INT344B:00 mode 1 0x44000702 0x0000001e [ACPI]
pin 7 (PIRQAB) 7:INT344B:00 GPIO 0x44000100 0x0000101f
pin 8 (CLKRUNB) 8:INT344B:00 mode 1 0x44000702 0x00000020
pin 9 (CLKOUT_LPC_0) 9:INT344B:00 mode 1 0x44000700 0x00001021 [ACPI]
pin 10 (CLKOUT_LPC_1) 10:INT344B:00 mode 1 0x44000700 0x00001022
pin 11 (PMEB) 11:INT344B:00 GPIO 0x44000102 0x00001023
pin 12 (BM_BUSYB) 12:INT344B:00 GPIO 0x44000100 0x00001024 [LOCKED]
pin 13 (SUSWARNB_SUS_PWRDNACK) 13:INT344B:00 mode 1 0x44000700 0x00000025
pin 14 (SUS_STATB) 14:INT344B:00 mode 1 0x44000700 0x00000026 [ACPI]
pin 15 (SUSACKB) 15:INT344B:00 mode 1 0x44000702 0x00003027 [ACPI]
pin 16 (SD_1P8_SEL) 16:INT344B:00 mode 1 0x44000500 0x00000028
pin 17 (SD_PWR_EN_B) 17:INT344B:00 mode 1 0x44000700 0x00000029
pin 18 (ISH_GP_0) 18:INT344B:00 GPIO 0x40800102 0x0000002a
pin 19 (ISH_GP_1) 19:INT344B:00 GPIO 0x40000100 0x0000102b
pin 20 (ISH_GP_2) 20:INT344B:00 GPIO 0x42000102 0x0000002c
pin 21 (ISH_GP_3) 21:INT344B:00 GPIO 0x44000201 0x0000002d
pin 22 (ISH_GP_4) 22:INT344B:00 GPIO 0x44000100 0x0000102e
pin 23 (ISH_GP_5) 23:INT344B:00 GPIO 0x44000100 0x0000102f
pin 24 (CORE_VID_0) 24:INT344B:00 GPIO 0x44000100 0x00001030
pin 25 (CORE_VID_1) 25:INT344B:00 GPIO 0x44000100 0x00001031
pin 26 (VRALERTB) 26:INT344B:00 GPIO 0x44000201 0x00000032
pin 27 (CPU_GP_2) 27:INT344B:00 GPIO 0x44000100 0x00001033
pin 28 (CPU_GP_3) 28:INT344B:00 GPIO 0x44000201 0x00000034
pin 29 (SRCCLKREQB_0) 29:INT344B:00 GPIO 0x44000100 0x00001035
pin 30 (SRCCLKREQB_1) 30:INT344B:00 GPIO 0x44000102 0x00003036
pin 31 (SRCCLKREQB_2) 31:INT344B:00 GPIO 0x44000102 0x00003037
pin 32 (SRCCLKREQB_3) 32:INT344B:00 mode 1 0x44000702 0x00003038
pin 33 (SRCCLKREQB_4) 33:INT344B:00 mode 1 0x44000702 0x00000039
pin 34 (SRCCLKREQB_5) 34:INT344B:00 mode 1 0x44000702 0x0000003a
pin 35 (EXT_PWR_GATEB) 35:INT344B:00 mode 1 0x44000700 0x0000003b [ACPI]
pin 36 (SLP_S0B) 36:INT344B:00 mode 1 0x44000700 0x0000003c
pin 37 (PLTRSTB) 37:INT344B:00 mode 1 0x44000700 0x0000003d
pin 38 (SPKR) 38:INT344B:00 GPIO 0x44000100 0x0000003e
pin 39 (GSPI0_CSB) 39:INT344B:00 GPIO 0x44000102 0x0000303f
pin 40 (GSPI0_CLK) 40:INT344B:00 GPIO 0x44000100 0x00001040
pin 41 (GSPI0_MISO) 41:INT344B:00 GPIO 0x46000102 0x00000041
pin 42 (GSPI0_MOSI) 42:INT344B:00 GPIO 0x44000100 0x00001042
pin 43 (GSPI1_CSB) 43:INT344B:00 GPIO 0x44000100 0x00001043
pin 44 (GSPI1_CLK) 44:INT344B:00 GPIO 0x44000100 0x00001044
pin 45 (GSPI1_MISO) 45:INT344B:00 GPIO 0x44000100 0x00001045
pin 46 (GSPI1_MOSI) 46:INT344B:00 GPIO 0x44000100 0x00001046
pin 47 (SML1ALERTB) 47:INT344B:00 GPIO 0x44000100 0x00001047
pin 48 (SMBCLK) 48:INT344B:00 mode 1 0x44000702 0x00002848
pin 49 (SMBDATA) 49:INT344B:00 mode 1 0x44000702 0x00002849
pin 50 (SMBALERTB) 50:INT344B:00 GPIO 0x44000100 0x0000104a
pin 51 (SML0CLK) 51:INT344B:00 GPIO 0x44000100 0x0000104b
pin 52 (SML0DATA) 52:INT344B:00 GPIO 0x44000100 0x0000104c
pin 53 (SML0ALERTB) 53:INT344B:00 GPIO 0x44000100 0x0000104d
pin 54 (SML1CLK) 54:INT344B:00 GPIO 0x44000100 0x0000104e
pin 55 (SML1DATA) 55:INT344B:00 GPIO 0x44000100 0x0000104f
pin 56 (UART0_RXD) 56:INT344B:00 GPIO 0x44000102 0x00000050 [ACPI]
pin 57 (UART0_TXD) 57:INT344B:00 GPIO 0x86080102 0x00000051 [ACPI]
pin 58 (UART0_RTSB) 58:INT344B:00 GPIO 0x44000201 0x00000052
pin 59 (UART0_CTSB) 59:INT344B:00 GPIO 0x44000102 0x00003053
pin 60 (UART1_RXD) 60:INT344B:00 GPIO 0x44000200 0x00002454
pin 61 (UART1_TXD) 61:INT344B:00 GPIO 0x44000100 0x00001055
pin 62 (UART1_RTSB) 62:INT344B:00 GPIO 0x44000100 0x00001056
pin 63 (UART1_CTSB) 63:INT344B:00 GPIO 0x44000100 0x00001057
pin 64 (I2C0_SDA) 64:INT344B:00 mode 1 0x44000702 0x00000058
pin 65 (I2C0_SCL) 65:INT344B:00 mode 1 0x44000702 0x00000059
pin 66 (I2C1_SDA) 66:INT344B:00 mode 1 0x44000702 0x0000005a
pin 67 (I2C1_SCL) 67:INT344B:00 mode 1 0x44000702 0x0000005b
pin 68 (UART2_RXD) 68:INT344B:00 mode 1 0x44000702 0x0000005c
pin 69 (UART2_TXD) 69:INT344B:00 mode 1 0x44000700 0x0000005d
pin 70 (UART2_RTSB) 70:INT344B:00 GPIO 0x44000200 0x0000245e
pin 71 (UART2_CTSB) 71:INT344B:00 GPIO 0x44000100 0x0000105f
pin 72 (SPI1_CSB) 72:INT344B:00 GPIO 0x44000100 0x00001060
pin 73 (SPI1_CLK) 73:INT344B:00 GPIO 0x44000100 0x00001061
pin 74 (SPI1_MISO_IO_1) 74:INT344B:00 GPIO 0x44000100 0x00001062
pin 75 (SPI1_MOSI_IO_0) 75:INT344B:00 GPIO 0x44000100 0x00001063
pin 76 (FLASHTRIG) 76:INT344B:00 GPIO 0x44000100 0x00001064
pin 77 (ISH_I2C0_SDA) 77:INT344B:00 GPIO 0x44000102 0x00000065
pin 78 (ISH_I2C0_SCL) 78:INT344B:00 GPIO 0x44000102 0x00000066
pin 79 (ISH_I2C1_SDA) 79:INT344B:00 GPIO 0x44000102 0x00000067
pin 80 (ISH_I2C1_SCL) 80:INT344B:00 GPIO 0x44000102 0x00000068
pin 81 (ISH_SPI_CSB) 81:INT344B:00 GPIO 0x44000100 0x00001069
pin 82 (ISH_SPI_CLK) 82:INT344B:00 GPIO 0x44000100 0x0000106a
pin 83 (ISH_SPI_MISO) 83:INT344B:00 GPIO 0x40000102 0x0000006b
pin 84 (ISH_SPI_MOSI) 84:INT344B:00 GPIO 0x40000102 0x0000006c
pin 85 (ISH_UART0_RXD) 85:INT344B:00 GPIO 0x44000100 0x0000106d
pin 86 (ISH_UART0_TXD) 86:INT344B:00 GPIO 0x44000100 0x0000106e
pin 87 (ISH_UART0_RTSB) 87:INT344B:00 GPIO 0x44000100 0x0000106f
pin 88 (ISH_UART0_CTSB) 88:INT344B:00 GPIO 0x44000100 0x00001070
pin 89 (DMIC_CLK_1) 89:INT344B:00 GPIO 0x44000200 0x00001071
pin 90 (DMIC_DATA_1) 90:INT344B:00 GPIO 0x44000100 0x00001072
pin 91 (DMIC_CLK_0) 91:INT344B:00 GPIO 0x44000201 0x00003073
pin 92 (DMIC_DATA_0) 92:INT344B:00 GPIO 0x04000201 0x00003074
pin 93 (SPI1_IO_2) 93:INT344B:00 GPIO 0x44000100 0x00001075
pin 94 (SPI1_IO_3) 94:INT344B:00 GPIO 0x44000100 0x00001076
pin 95 (SSP_MCLK) 95:INT344B:00 GPIO 0x44000100 0x00001077
pin 96 (SATAXPCIE_0) 96:INT344B:00 GPIO 0x44000100 0x00001018
pin 97 (SATAXPCIE_1) 97:INT344B:00 mode 1 0x44000700 0x00001019
pin 98 (SATAXPCIE_2) 98:INT344B:00 GPIO 0x44000100 0x0000101a
pin 99 (CPU_GP_0) 99:INT344B:00 GPIO 0x44000100 0x0000101b
pin 100 (SATA_DEVSLP_0) 100:INT344B:00 GPIO 0x44000100 0x0000101c
pin 101 (SATA_DEVSLP_1) 101:INT344B:00 mode 1 0x04000700 0x0000001d
pin 102 (SATA_DEVSLP_2) 102:INT344B:00 GPIO 0x44000100 0x0000101e
pin 103 (CPU_GP_1) 103:INT344B:00 GPIO 0x84000100 0x0000001f
pin 104 (SATA_LEDB) 104:INT344B:00 GPIO 0x44000100 0x00001020
pin 105 (USB2_OCB_0) 105:INT344B:00 mode 1 0x44000702 0x00000021
pin 106 (USB2_OCB_1) 106:INT344B:00 mode 1 0x44000702 0x00000022
pin 107 (USB2_OCB_2) 107:INT344B:00 GPIO 0x44000301 0x00000023
pin 108 (USB2_OCB_3) 108:INT344B:00 GPIO 0x44000100 0x00001024
pin 109 (DDSP_HPD_0) 109:INT344B:00 mode 1 0x44000700 0x00000025
pin 110 (DDSP_HPD_1) 110:INT344B:00 mode 1 0x44000700 0x00000026
pin 111 (DDSP_HPD_2) 111:INT344B:00 mode 1 0x44000702 0x00000027
pin 112 (DDSP_HPD_3) 112:INT344B:00 GPIO 0x80880102 0x00003028 [ACPI]
pin 113 (EDP_HPD) 113:INT344B:00 mode 1 0x44000702 0x00000029
pin 114 (DDPB_CTRLCLK) 114:INT344B:00 mode 1 0x44000702 0x0000002a
pin 115 (DDPB_CTRLDATA) 115:INT344B:00 mode 1 0x44000702 0x0000102b
pin 116 (DDPC_CTRLCLK) 116:INT344B:00 GPIO 0x44000100 0x0000102c
pin 117 (DDPC_CTRLDATA) 117:INT344B:00 GPIO 0x44000102 0x0000102d
pin 118 (DDPD_CTRLCLK) 118:INT344B:00 GPIO 0x44000100 0x0000102e
pin 119 (DDPD_CTRLDATA) 119:INT344B:00 GPIO 0x44000100 0x0000102f
pin 120 (SSP2_SCLK) 120:INT344B:00 GPIO 0x44000200 0x00001030
pin 121 (SSP2_SFRM) 121:INT344B:00 GPIO 0x44000200 0x00001031
pin 122 (SSP2_TXD) 122:INT344B:00 GPIO 0x44000200 0x00001032
pin 123 (SSP2_RXD) 123:INT344B:00 GPIO 0x44000200 0x00001033
pin 124 (I2C2_SDA) 124:INT344B:00 mode 1 0x44000702 0x02000034
pin 125 (I2C2_SCL) 125:INT344B:00 mode 1 0x44000702 0x02000035
pin 126 (I2C3_SDA) 126:INT344B:00 GPIO 0x44000201 0x00001036
pin 127 (I2C3_SCL) 127:INT344B:00 GPIO 0x82800102 0x00003037
pin 128 (I2C4_SDA) 128:INT344B:00 GPIO 0x40080100 0x00000038
pin 129 (I2C4_SCL) 129:INT344B:00 GPIO 0x44000201 0x00003039
pin 130 (I2C5_SDA) 130:INT344B:00 GPIO 0x44000200 0x0000103a
pin 131 (I2C5_SCL) 131:INT344B:00 GPIO 0x44000201 0x0000003b
pin 132 (EMMC_CMD) 132:INT344B:00 mode 1 0x44000700 0x0000003c
pin 133 (EMMC_DATA_0) 133:INT344B:00 mode 1 0x44000700 0x0000003d
pin 134 (EMMC_DATA_1) 134:INT344B:00 mode 1 0x44000700 0x0000003e
pin 135 (EMMC_DATA_2) 135:INT344B:00 mode 1 0x44000700 0x0000003f
pin 136 (EMMC_DATA_3) 136:INT344B:00 mode 1 0x44000700 0x00000040
pin 137 (EMMC_DATA_4) 137:INT344B:00 mode 1 0x44000700 0x00000041
pin 138 (EMMC_DATA_5) 138:INT344B:00 mode 1 0x44000700 0x00000042
pin 139 (EMMC_DATA_6) 139:INT344B:00 mode 1 0x44000700 0x00000043
pin 140 (EMMC_DATA_7) 140:INT344B:00 mode 1 0x44000700 0x00000044
pin 141 (EMMC_RCLK) 141:INT344B:00 mode 1 0x44000700 0x00000045
pin 142 (EMMC_CLK) 142:INT344B:00 mode 1 0x44000700 0x00000046
pin 143 (GPP_F_23) 143:INT344B:00 GPIO 0x44000200 0x00001047
pin 144 (SD_CMD) 144:INT344B:00 mode 1 0x44000700 0x00000048
pin 145 (SD_DATA_0) 145:INT344B:00 mode 1 0x44000700 0x00000049
pin 146 (SD_DATA_1) 146:INT344B:00 mode 1 0x44000700 0x0000004a
pin 147 (SD_DATA_2) 147:INT344B:00 mode 1 0x44000700 0x0000004b
pin 148 (SD_DATA_3) 148:INT344B:00 mode 1 0x44000700 0x0000004c
pin 149 (SD_CDB) 149:INT344B:00 mode 1 0x44000702 0x0000304d
pin 150 (SD_CLK) 150:INT344B:00 mode 1 0x44000700 0x0000004e
pin 151 (SD_WP) 151:INT344B:00 mode 1 0x44000700 0x0000004f

-- 
Best regards,
Marek Vasut

