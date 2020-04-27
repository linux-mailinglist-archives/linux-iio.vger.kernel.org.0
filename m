Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508D51B9921
	for <lists+linux-iio@lfdr.de>; Mon, 27 Apr 2020 09:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgD0H54 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Apr 2020 03:57:56 -0400
Received: from mail-eopbgr20113.outbound.protection.outlook.com ([40.107.2.113]:55430
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725785AbgD0H5z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 Apr 2020 03:57:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVSRxrHCiQeEcjznMhZu+SPAdJTlCqWVUAPupTVGln1r8JDjZXXssr+ZSHa4zZ/WqreLmHrtSEGM5NqbYGTn8qZBOY7bFn/1hnJm7PaPbvalV4v5T/CrRBqdn9JRTYUxlAhntE4qmSW/xr0vMHJmRiKa5D8Sow+ZJ92u3jbEmd6Hlpzz6EnR+t0mt+/Y/INs6sl2i6bP/Lk5Bt4ckx26SR8mBGYVJR0usUh/jSWcRz7hgyGh5CIg7E6IyRykN3QBsABIdxOEnfIX7GAsPngh0/sETLcpghR91aI1qMTRK6bZe+BwrEIFOXcYdgsMU2+iDrSYRg0J+tNdamML1dvJlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYS5WhcG1LJpzVDbgPPqMEwqKcVKqz79FBXpD5ntIFY=;
 b=OkdpsiOVc0aNUVyKrA9LPZUZQUlDFfJh9A3Ug1P7Mi9CD5TgRwQdTOYzoyWWdWgVA00h2PkHSd+RB6b5/Nj2/UEHdS+89PHqZyjKX226u1I/t0iBgY8HN7jz+JeXmeTPiAkDCuwiovqFEgSLBchEgaawxYfvljgf2VzWa+f+Yw8bGP093E7GWlfHzQ7oiX+Kj4FanuHkVcBmc8aOyX7mv8v4TXWHpEY846g+0IT97wcS4uzlaQnogS7Y9Ssr6re0KNTiYFckdsuZYySFQAa+ntTfHkh6bgRRNaRCrBFko/A+5EVsLc+3HuYo6zGiO18ZlKJiyDo2+eLGyWB+vwFrLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=norphonic.com; dmarc=pass action=none
 header.from=norphonic.com; dkim=pass header.d=norphonic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trafsysas.onmicrosoft.com; s=selector2-trafsysas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYS5WhcG1LJpzVDbgPPqMEwqKcVKqz79FBXpD5ntIFY=;
 b=oViM41xWtinyaoddRDM98wqnYj/0c3Mch7EdJSm3zTBTmyJPCjlsSDNvPpU6SmmPuzdQGzSq/oWM3gbcrcGYmP1mgNWnNdN0pFwYVC83WkKJfhRmrj7m19BAfBOGfYgQVPZKuFY6yoP/SXgLL38YfYchAN5z+Fz37SzTXP+HWPw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ez@norphonic.com; 
Received: from AM6PR06MB5430.eurprd06.prod.outlook.com (2603:10a6:20b:86::11)
 by AM6PR06MB5224.eurprd06.prod.outlook.com (2603:10a6:20b:82::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 07:57:51 +0000
Received: from AM6PR06MB5430.eurprd06.prod.outlook.com
 ([fe80::9814:8ea:8170:5678]) by AM6PR06MB5430.eurprd06.prod.outlook.com
 ([fe80::9814:8ea:8170:5678%5]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 07:57:51 +0000
Subject: Re: [PATCH v7 1/2] Driver for TI HDC20x0 humidity and temperature
 sensors
To:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Eugene Zalkonnikov <ez@norphonic.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <E372084A-C6C5-4261-90C5-B810ADAFDD73@norphonic.com>
 <alpine.DEB.2.21.2004270024590.16743@vps.pmeerw.net>
From:   Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>
Message-ID: <7482ee6f-eedb-8482-d30e-7fa8e9b0fd47@norphonic.com>
Date:   Mon, 27 Apr 2020 09:57:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <alpine.DEB.2.21.2004270024590.16743@vps.pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: OL1P279CA0051.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:14::20) To AM6PR06MB5430.eurprd06.prod.outlook.com
 (2603:10a6:20b:86::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.1.54] (62.97.226.122) by OL1P279CA0051.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:14::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 07:57:50 +0000
X-Originating-IP: [62.97.226.122]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5790da8a-f554-4be6-7eea-08d7ea80aee9
X-MS-TrafficTypeDiagnostic: AM6PR06MB5224:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR06MB52243FF3287D98610516AEC2CAAF0@AM6PR06MB5224.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR06MB5430.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(396003)(366004)(39830400003)(346002)(4326008)(66946007)(81156014)(53546011)(508600001)(66556008)(2906002)(31686004)(186003)(2616005)(16526019)(956004)(5660300002)(44832011)(6636002)(26005)(54906003)(36756003)(31696002)(8936002)(8676002)(110136005)(16576012)(66476007)(316002)(6486002)(52116002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: norphonic.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q+XFoqP3LXzewqx4+Kt5pbBvwJLekAd29ICvjP5yfFll+Hr0PwXhIIS205uqmqX3uhc1jaWyneuHIUAheTi0hngyALMvjF1Ysp5QHeMXLgdbEgkIO1N3OWmB8+VF17+hVTO9KJC3PKTX1v1EdHB/KQ5PH2PSe9fRLlhB6uSCJZzWzL7t9p+j700Di4JTc2uq4ZdKZ7eHJwYqIg4Gv685BSjsONHLZ+kTEGbVu3N/xUCX/aUaI7rjn0Z26BDEl30cXxmfVcOQqIB+T/6ZITVPsTN8FoiAa1EnXuu9E+YcuNZCnQHVn7RQt0gbm0p1O/cTTQ4MP7ZrEOQSApxHRb2T6gnEerm5lIHM8Doy5A9ChbStExzGgwl8/ul4uMgWXeo9JvCSXZ5GaYTKTIXw6OV7QN0NiIhctFeNLJrE2biw3CDNFSfuY9yIRWRqWPe4rq9o
X-MS-Exchange-AntiSpam-MessageData: yLMsPodrtFkSHD1J6/w9gam/wEF80D1XMsb0JT+WVzwQBWxhWX6I07CBYRtyxhtGWtgIrmUwUxs77J1eCaczOTIsUY2vhl42xD789hASvmKhDCNm+a0F78hMUB4sy54R+K7h6GmsEMh9PYp4u4uPxpeLLacsbLhXZvp7cf9r/W/AHxZSbjImzFXTdFkNf56VI8zm1/Uh8iN8Bu/i8qBIT2OlrsQd/qC062uafXB1kZ/9PhQvedfeFhULjIB2SCvKd2cunElSuGLVliUN1SA8tH0x6aWOUp8Et6HcxQrMEp97eHc12Z9u6QvukRvRaeW1+D6NCjf00qMzhZM81EJMFDbEby/hcM+0LICCFLRSLuADnN/7Flg+OBslq8GKBK7UpbUBcFO0SkiBw14xC9OR+4Ot2dpSv7xrmIDq8tJDzjyzwLdEEwZoq5/PbKO3OIZAmZrYmQtVOWVnEIMRdeyWiiGGWEjzGlVy/KeChWMuVWXoMriDXLmHB13D7SxEEt43usEJFdAszGMo3uMBEE05/k4UX5cY0VVVsQtzknOJqsAS8BUg782PXUXIq6Q+pe8/28BcLsd08wwyJclmz8ajbeSkATE8C20dIXPwmMRJU/nfcB7HBP4ZcY95F9j+ygPhdTiB+oXlP/RYsPsZajdRx17QMJWqeCOwEkYDt8Gp0ZJcpZCmsyvEPwd12iJriAysWNf3Mho/Na6is3ug2+UkCfEtcUxxQ1a+B6qa3dbBXnq1kFkT3BP9M3z+fzHAhriPptBYWZuCIwAair1LgbIEf4oXXy8Scil0jDNvyUgN500=
X-OriginatorOrg: norphonic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5790da8a-f554-4be6-7eea-08d7ea80aee9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 07:57:50.9774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cbf3f496-45ad-415e-97cb-4e62d6cd974f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCU5DlzogAzagiafcq9Lket07xgoyTmaq/h2OdD4o6JdxZ79e/5+zIYtciTvPPqlGRlJHVSBRzMpA5VnSZj+ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB5224
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Peter,


On 27.04.2020 00:35, Peter Meerwald-Stadler wrote:
>> +{
>> +	struct i2c_client *client = data->client;
>> +	s32 ret;
>> +
>> +	ret = i2c_smbus_read_byte_data(client,
>> +			hdc2010_reg_translation[chan->address].peak);
>> +
>> +	if (ret < 0)
>> +		dev_err(&client->dev, "Could not read sensor data\n");
>> +
>> +	return ret;
>> +}
>> +
>> +static int hdc2010_get_heater_status(struct hdc2010_data *data)
> return value should be bool?

No idea. It is an int in hdc100x hdc heater sysfs and I try to stick to existing practices.

Should those be bools?

>
>> +	case IIO_CHAN_INFO_PEAK: {
>> +		int ret;
>> +
>> +		ret = iio_device_claim_direct_mode(indio_dev);
>> +		if (ret)
>> +			return ret;
>> +		mutex_lock(&data->lock);
>> +		ret = hdc2010_get_peak_measurement_byte(data, chan);
>> +		mutex_unlock(&data->lock);
>> +		iio_device_release_direct_mode(indio_dev);
>> +		if (ret < 0)
>> +			return ret;
>> +		/* Scaling up the value so we can use same offset as RAW */
>> +		*val = ret * 256;
> I'd rather have different _SCALEs for peak and raw

They are made shared per Jonathan's suggestion early on, as the offsets for the channels don't match.


Regards,

   Eugene.

