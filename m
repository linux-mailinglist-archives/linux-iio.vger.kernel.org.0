Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8928186CFF
	for <lists+linux-iio@lfdr.de>; Mon, 16 Mar 2020 15:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731471AbgCPO0g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Mar 2020 10:26:36 -0400
Received: from www381.your-server.de ([78.46.137.84]:45636 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729710AbgCPO0g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Mar 2020 10:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yTe2A+Twf6hP/tiYtDVMP8Wrdt323UTRH8eQ9gKxgjA=; b=LSpJ1nSKt31Ngut5gMiKPvAoC+
        PF90SPwUmwugvILDua7LjP2pip3aCmOoLrlduv4ntEhkUBIKN2+eB+aPNUtY6v3sdqNff1GxiY1CW
        6lzFil8meZaW2+vII4VxD97crxdUEjXN3ARz+IWYhYZhrzuoZD6b87t8BM2QTonaWLpBUXwMI2gxD
        GVrJJxBsAJe+ovUD4Ld+o7zgXOW+4W50tkISZDI98NNMcfjAVZTsxc6gek/mMJGnqwtGMlV2OwLs2
        NUBWVP0Ezsz/CYs6d7W4QpX4Bfw+PmEQOkIKOw0LSeMQ37vWUCUSfqE3rsnhH1SHeAYdHRLA95znO
        UFvRvmvA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jDqhN-0003we-3Q; Mon, 16 Mar 2020 15:26:33 +0100
Received: from [93.104.121.61] (helo=[192.168.178.20])
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jDqhM-000F2q-N8; Mon, 16 Mar 2020 15:26:32 +0100
Subject: Re: [PATCH v2 5/6] iio: imu: Add support for adis16475
To:     =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
References: <20200316125312.39178-1-nuno.sa@analog.com>
 <20200316125312.39178-6-nuno.sa@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <07c41ab8-7b09-0eb3-ce9d-d7773f5186b8@metafoo.de>
Date:   Mon, 16 Mar 2020 15:26:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316125312.39178-6-nuno.sa@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25753/Mon Mar 16 14:05:55 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/16/20 1:53 PM, Nuno Sá wrote:
> Support ADIS16475 and similar IMU devices. These devices are
> a precision, miniature MEMS inertial measurement unit (IMU) that
> includes a triaxial gyroscope and a triaxial accelerometer. Each
> inertial sensor combines with signal conditioning that optimizes
> dynamic performance.
>
> The driver adds support for the following devices:
>   * adis16470, adis16475, adis16477, adis16465, adis16467, adis16500,
>     adis16505, adis16507.
>
Looks very good, just a few comments and questions. I like the solution 
for the 32-bit registers.

> +static int adis16475_set_freq(struct adis16475 *st, const u32 freq)
> +{
> +	u16 dec;
> +	int ret;
> +
> +	if (freq == 0 || freq > st->clk_freq)
> +		return -EINVAL;

Maybe round down if freq is larger the maximum rate. I believe we do 
that same for other drivers.

> +
> +	dec = DIV_ROUND_CLOSEST(st->clk_freq, freq);
> +
> +	if (dec)
> +		dec--;
> +
> +	if (dec > st->info->max_dec)
> +		dec = st->info->max_dec;
> +
> +	ret = adis_write_reg_16(&st->adis, ADIS16475_REG_DEC_RATE, dec);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * If decimation is used, then gyro and accel data will have meaningfull
Typo: "meaningful"
> +	 * bits on the LSB registers. This info is used on the trigger handler.
> +	 */
> +	if (!dec)
> +		clear_bit(ADIS16475_LSB_DEC_MASK, &st->lsb_flag);
> +	else
> +		set_bit(ADIS16475_LSB_DEC_MASK, &st->lsb_flag);
> +
> +	return 0;
> +}
> +
> +/* The values are approximated. */
> +static const u32 adis16475_3db_freqs[] = {
> +	[0] = 720, /* Filter disabled, full BW (~720Hz) */
> +	[1] = 360,
> +	[2] = 164,

164 is the only one that does not follow the pattern of 720 / (2**n). 
Not sure if that is on purpose. But either way where did you find the 
bandwidths for the different filter settings? I had a quick look at the 
datasheet and could not find anything.

Maybe it also makes sense to consider the clock rate when running in 
sync mode as the bandwidth will be a function of the sampling rate.

> +	[3] = 80,
> +	[4] = 40,
> +	[5] = 20,
> +	[6] = 10,
> +	[7] = 10, /* not a valid setting */
> +};
> +
> +static int adis16475_get_filter(struct adis16475 *st, u32 *filter)
> +{
> +	u16 filter_sz;
> +	int ret;
> +	const int mask = ADIS16475_FILT_CTRL_MASK;
> +
> +	ret = adis_read_reg_16(&st->adis, ADIS16475_REG_FILT_CTRL, &filter_sz);
> +	if (ret)
> +		return ret;
> +
> +	*filter = adis16475_3db_freqs[filter_sz & mask];
> +
> +	return 0;
> +}
> +
> +static int adis16475_set_filter(struct adis16475 *st, const u32 filter)
> +{
> +	int i;
> +	int ret;
> +
> +	for (i = ARRAY_SIZE(adis16475_3db_freqs) - 1; i >= 1; i--) {
> +		if (adis16475_3db_freqs[i] >= filter)
> +			break;
> +	}

If the filter frequency is less or equal to 10, this will pick 7 for i. 
But the comment above says that it is an invalid setting.

>
> +static u16 adis16475_validate_crc(const u8 *buffer, const u16 crc,
> +				  const bool burst32)
Return type is u16, but the return value is bool. Also validate kind of 
suggests that it returns true if valid, but right now it returns true if 
invalid.
> +{
> +	int i;
> +	u16 __crc = 0;

I find having both __crc and crc a bit confusing, maybe give them names 
which better describe them. Maybe computed_crc or expected_crc. Or as an 
alternative I think also just crc -= buffer[i] in the loop and crc != 0 
at the end should work.


> +	/* extra 6 elements for low gyro and accel */
> +	const u16 sz = burst32 ? ADIS16475_BURST32_MAX_DATA :
> +		ADIS16475_BURST_MAX_DATA;
> +
> +	for (i = 0; i < sz - 2; i++)
> +		__crc += buffer[i];
> +
> +	return (__crc != crc);
> +}
> +
> +static void adis16475_burst32_check(struct adis16475 *st)
> +{
> +	int ret;
> +	struct adis *adis = &st->adis;
> +
> +	if (!st->info->has_burst32)
> +		return;
> +
> +	if (st->lsb_flag && !st->burst32) {
> +		const u16 en = ADIS16500_BURST32(1);
> +
> +		ret = __adis_update_bits(&st->adis, ADIS16475_REG_MSG_CTRL,
> +					 ADIS16500_BURST32_MASK, en);
> +		if (ret < 0)
> +			return;
> +
> +		st->burst32 = true;
> +		/*
> +		 * In 32bit mode we need extra 2 bytes for all gyro
> +		 * and accel channels.
> +		 */
> +		adis->burst->extra_len += 6 * sizeof(u16);

I believe this breaks if you have more than one device instance as 
adis->burst points to a global struct that is shared between all 
instances. extra_len should probably be part of the adis struct itself 
and then make the burst field const.

> +		adis->xfer[1].len += 6 * sizeof(u16);
> +		dev_dbg(&adis->spi->dev, "Enable burst32 mode, xfer:%d",
> +			adis->xfer[1].len);
> +
> +	} else if (!st->lsb_flag && st->burst32) {
> +		const u16 en = ADIS16500_BURST32(0);
> +
> +		ret = __adis_update_bits(&st->adis, ADIS16475_REG_MSG_CTRL,
> +					 ADIS16500_BURST32_MASK, en);
> +		if (ret < 0)
> +			return;
> +
> +		st->burst32 = false;
> +		/* Remove the extra bits */
> +		adis->burst->extra_len -= 6 * sizeof(u16);
> +		adis->xfer[1].len -= 6 * sizeof(u16);
> +		dev_dbg(&adis->spi->dev, "Disable burst32 mode, xfer:%d\n",
> +			adis->xfer[1].len);
> +	}
> +}
> +

