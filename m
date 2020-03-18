Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 202D0189908
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 11:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgCRKP4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 06:15:56 -0400
Received: from www381.your-server.de ([78.46.137.84]:44976 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgCRKP4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 06:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uePrIDfqBZFnSgWVkXPSgRpt9QzNhv5Xk2uw/MF+wAQ=; b=ebpeu+gagAEFuS42nV1oG3kE5e
        NSy2cJXISlUO+nuF+TnQD3ezVwRoApVQ79s4wa8Q0ncqZSe9NbQn9L29j2bpPM34EVtHy7OYxySgd
        2AUMT3vm59/S72rSK9Ru/FKCiR04au/QfQ7uiqIapoPgUjn/UJ2Ozpm90/X90rjKkGgKBbEVAirCA
        +WAFjq1w1pudGk48EJz8QlVFr812Mfdryvf7QoQBHWjrLj9htPoSu2K2JGb8ptQSfajmzS32jlX/E
        wHeftb4Ubx8/x+dNOrMtpYgCauBAPGh9xVQYbsohCBq62Abi+5eghYiUULjnc+oFzTK9K/hl+bcLY
        As2fU0FQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jEVjt-0006lh-Li; Wed, 18 Mar 2020 11:15:53 +0100
Received: from [93.104.115.49] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jEVjt-0007Fn-Eg; Wed, 18 Mar 2020 11:15:53 +0100
Subject: Re: [PATCH v3 3/4] iio: accel: adxl372: add additional events ABIs
To:     Alexandru Tachici <tachicialex@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org
References: <20200318110958.8621-1-alexandru.tachici@analog.com>
 <20200318110958.8621-4-alexandru.tachici@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <c140a2ab-2da8-2c56-3ab6-193bb52a46cb@metafoo.de>
Date:   Wed, 18 Mar 2020 11:15:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318110958.8621-4-alexandru.tachici@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25754/Tue Mar 17 14:09:15 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/18/20 12:09 PM, Alexandru Tachici wrote:
> Adxl372 uses the standard event interface. The additional
> ABIs aim to explain to the user that the values set in
> ./events/thresh_falling_period and ./events/thresh_rising_period
> control the state of the device, not just the events timings.
> 

Hi,

I'm not convinced this is a good idea. Since this is non-standard ABI 
the user would likely have to consult the documentation to figure out 
what this means. So we might as well document in the documentation that 
for peak mode the thresholds are configured through the event API.

- Lars
