Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32F79151CF3
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2020 16:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbgBDPK0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Feb 2020 10:10:26 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41447 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbgBDPK0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Feb 2020 10:10:26 -0500
Received: by mail-lf1-f65.google.com with SMTP id m30so12418852lfp.8;
        Tue, 04 Feb 2020 07:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bOyXqJTMJpGxnWbJ6CKeee1fvpUr341gEX8SV5oQQCU=;
        b=O1TlePiADJbKYBupj2fnfW870fVe17j9u063poPBQPqY7ir3uqzJOTSVXiaYkEIbWP
         1MVljGSK/AFYpXl7E7f3FAWhegZUGafflyTuItUYgLOC5JmkEr1goIJSu/98JbxklCIU
         BBXE2nyWTgglSSx2CCIHoYxG68uXWpXMMRz7PK8ymhKkJ3KGM4ObMtVN75Sh9rjzWeyx
         gtwVNVbvVzGV8FbTEbADzpBz9sovCKWn/5QJOWW4m9/mx9zNMFr/zJL5lDTjeuz75jZv
         DH51aD5OQ/bxcHxp+T/aeSnrU2mefIaZFUZzytVopmFdEDtXoOc1vphdLSJ9jKL6Tye/
         xN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bOyXqJTMJpGxnWbJ6CKeee1fvpUr341gEX8SV5oQQCU=;
        b=YvqrmvzQ4v4ZalKnZywmK2F1h8k0NeDzF/+1oaIEeU5kxjJNFwh8lywKI2ebH+TUqd
         0kpfOmw+yxv9Bu/cHdQi2oYc4v6IS31vXunO5/hz5bBd2IKTk8/o7dKwN30qJs8Goc+Z
         /xwHZej4pdni5WJJugnnx/dp5TdLbZDEEC2yQzt+dRpwjFrxzKW0alKjq5pDo/F0KQJ0
         3QSz+RrI/34X32524cctOSmaFIsC+cN60PL5LqCnJzLNWwZ3znpoYDHajGfry5te82da
         mMnCjj9Q+klIdjuXCwbu2m5eOUUP0IW1vR0ixc9YnSFHw2wz7qqc5SXaDKmNgNIvleK2
         tINQ==
X-Gm-Message-State: APjAAAUcnU/7oEAKMFfh9uzFSdAkQn9ZXvDqiEPG1TtDkI9OJ1dmWc01
        Ct4DaPm95WI8qEM0JVM6zz1YbtHQ
X-Google-Smtp-Source: APXvYqwwbabdhnCboq2+5Sp2du8E38mwDuKCHSWZXOTDF1Yt+bgOaUDExFDy6Q2DRXDV8qm2fFAHuQ==
X-Received: by 2002:a19:cc07:: with SMTP id c7mr15243564lfg.177.1580829023688;
        Tue, 04 Feb 2020 07:10:23 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id i4sm13804144lji.0.2020.02.04.07.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 07:10:23 -0800 (PST)
Subject: Re: [PATCH v4 2/7] dt-bindings: iio: light: add support for
 Dyna-Image AL3010
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
References: <20200204093031.616409-1-david@ixit.cz>
 <20200204093031.616409-3-david@ixit.cz> <20200204095257.GA23609@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <193d39c7-a89b-17ee-1f8f-a6f6fbf6485c@gmail.com>
Date:   Tue, 4 Feb 2020 18:10:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200204095257.GA23609@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

04.02.2020 12:52, Michał Mirosław пишет:
> On Tue, Feb 04, 2020 at 10:30:30AM +0100, David Heidelberg wrote:
>> The Dyna-Image AL3010 is a 16-bit digital ambient light sensor which
>> provides a multiple gain function with linear response over a dynamic
>> range 1216/4863/19452/77806.
> [...]
>> +properties:
>> +  compatible:
>> +    const: dynaimage,al3010
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  vdd-supply:
>> +    description: Regulator that provides power to the sensor
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - vdd-supply
> 
> Regulator and interrupt should be optional.

Indeed, that's a good correction +1
