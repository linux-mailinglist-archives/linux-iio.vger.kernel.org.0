Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6668F3595DC
	for <lists+linux-iio@lfdr.de>; Fri,  9 Apr 2021 08:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbhDIGwt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Apr 2021 02:52:49 -0400
Received: from www381.your-server.de ([78.46.137.84]:48566 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbhDIGwn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Apr 2021 02:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=RLEoa/8G3ilSJPXImnUYOkUDSVQwMjz0bBC+96PHorI=; b=ZSbyz1/zZIK4dXsglS/MwKSnQz
        w26YI3p7fibNpvNuir+Wru7OQPs+Nv8tZnYEbxahiwmL4wAOuE8oALkvqjuzH+a6fOdXuSMjT+J4Q
        6SXIlyOux0RffW8PB78vKDD7K0J3R35p0fA9KmPcnY1JkSxsxKEd1o7hksr39BlAO27FKxVjMegS+
        aXRFMUh/mfHrw8EAJptDdAwX48nGkaRw0fT0POFPw6wBCnW+O/4GRBo5puMuZ9JvFrXdk9Ysx9RVP
        EcgFRv0I04iSjFKtlZEHnHyo2nhMKS8XoAHT1G2CQbyxH1trsN5QwRAkRoUbQSWdvHDZda/khtIoJ
        3NkQqDog==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lUl0H-0001kx-8n; Fri, 09 Apr 2021 08:52:29 +0200
Received: from [2001:a61:2bab:901:9e5c:8eff:fe01:8578]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lUl0H-000OJC-4Y; Fri, 09 Apr 2021 08:52:29 +0200
Subject: Re: [PATCH v2] iio: adis16480: support burst read function
To:     Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>
References: <20210408075643.70183-1-nuno.sa@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <c94d1489-a9d6-8e86-80de-fc1936608d08@metafoo.de>
Date:   Fri, 9 Apr 2021 08:52:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210408075643.70183-1-nuno.sa@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26134/Thu Apr  8 13:08:38 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/8/21 9:56 AM, Nuno Sa wrote:
> Some supported devices support burst read function. This provides a method
> for reading a batch of data (status, temperature, gyroscopes,
> accelerometers, time stamp/data counter, and CRC code), which does not
> require a stall time between each 16-bit segment and only requires one
> command on the DIN line to initiate. Devices supporting this mode
> are:
>
>    * adis16495-1
>    * adis16495-2
>    * adis16495-3
>    * adis16497-1
>    * adis16497-2
>    * adis16497-3
>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>

Looks good to me.

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

