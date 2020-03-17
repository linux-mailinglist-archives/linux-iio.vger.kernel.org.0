Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B872188F26
	for <lists+linux-iio@lfdr.de>; Tue, 17 Mar 2020 21:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgCQUkH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Mar 2020 16:40:07 -0400
Received: from www381.your-server.de ([78.46.137.84]:35092 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgCQUkH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Mar 2020 16:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=asOgqdEwt+CS4aSpUwgFMGUjb57eYhc/NUJd+7xUpmE=; b=aU97iuZwHk0XzQResfr9j5mojX
        n7i2AWPCoMyyHREonc6/ogCG9FC/MScgA+DHSd9418GcyQdgOCKp0tRTMzVtiXEzkDQu3KbpMohgA
        g3uLeluSL+O8+kuGiLFUzZF7HWfbvy5IlgxQ6uhImw14sF42umAf4bh+HrFOZmPLwlHdTJN5HR3dh
        OMB7uhPKkrayYdzrBpBvLDiupWlxE0LRAaDY/RmlQDbXR2ucKoHurNCJ0gWl68ue4fTpv2Chm/11c
        YyqjUc5hcDuS5jsACQK6H4zcBupmBDUsbPp6iZRgFZH7iM/sNhnhmcxPoHWlkxW+2DgN0q+oIaXUb
        hToahyIg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jEJ0Q-0007hT-0Z; Tue, 17 Mar 2020 21:40:06 +0100
Received: from [93.104.105.202] (helo=[192.168.178.20])
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jEJ0P-000DCe-N4; Tue, 17 Mar 2020 21:40:05 +0100
Subject: Re: [PATCH 1/2] iio: adc: Add MAX1241 driver
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Alexandru Lazar <alazar@startmail.com>, linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com
References: <20200317201710.23180-1-alazar@startmail.com>
 <20200317201710.23180-2-alazar@startmail.com>
 <370e807c-da03-e925-2eac-1e7e92c124e4@metafoo.de>
Message-ID: <b193171b-ab39-f34e-052a-29cb30c6fc47@metafoo.de>
Date:   Tue, 17 Mar 2020 21:40:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <370e807c-da03-e925-2eac-1e7e92c124e4@metafoo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25754/Tue Mar 17 14:09:15 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/17/20 9:33 PM, Lars-Peter Clausen wrote:
> On 3/17/20 9:17 PM, Alexandru Lazar wrote:
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 5d8540b7b427..3a55beec69c9 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -566,6 +566,18 @@ config MAX1118
>>         To compile this driver as a module, choose M here: the module 
>> will be
>>         called max1118.
>> +config MAX1241
>> +    tristate "Maxim max1241 ADC driver"
>> +    depends on SPI
> 
> depends on SPI_MASTER
> 
> There is also SPI_SLAVE support no in the kernel and just SPI does not 
> imply SPI_MASTER.

Sorry, that is of course not true. SPI does imply SPI_MASTER. Still 
SPI_MASTER is the correct dependency here.
