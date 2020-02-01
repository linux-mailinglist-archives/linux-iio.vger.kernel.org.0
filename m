Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27D8A14FA0F
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2020 19:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgBAS72 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Feb 2020 13:59:28 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36916 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgBAS72 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Feb 2020 13:59:28 -0500
Received: by mail-lf1-f66.google.com with SMTP id b15so7068749lfc.4;
        Sat, 01 Feb 2020 10:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/phYC3XepYJ8HcBAgyCtC3+v9VkhmdsR0sH380NesxM=;
        b=DH9NbU0ALqHKtTRfsqL59umJ9dO7pBbRSvtbDH+ndY8xHDRorsCqqSzPnpumOM21g0
         2K/vgjYlwyfcMhsf4zpcU/K1ajiej13gBHNxrgeJfA0HTfI69hFiXxsP51P1VqFDzyLy
         dseV7w75afQZlyo4OxtOKIWiZuRAUBk0DknwLh235xo6wuOGX8yog/hTyYmOxHi7O4dW
         Y5veaNagCaXPQM3Fsy5skvOS/nn6+VwWmrxw0QQ2ikQ2sDerovm5Xj/6jJ24vTVY0sJa
         r/mOJTjkYqzTWMFL6IDe/mM3yh8uh3/0TV1I5/f8AKfvzS5oJEawisADickxwUBnKdl/
         wTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/phYC3XepYJ8HcBAgyCtC3+v9VkhmdsR0sH380NesxM=;
        b=tDU1apYl9J7UDNMLMDDtIzrhGn97AlHDCOzRjM9/787BIsRDK+BLQoEbLka6xL4qXz
         HETc+hO9N8wt6p0c1IDARH7mLo6gM3LDDvKOIh+RvnEyF6L7xqiEdLP/alOaMLEPsZMa
         euwZ+TnqykLPQ1YNmCZDUt7FIFBKuWTIcfXaOZjhOLiCT+RK966poPE8Tuz9nuwwukGz
         94nuNQefumqEByQgX0/c6HIf2rHE/RfU7jlqzdjbkMcrB3dL7l03Xg99Bh7086CAimV8
         SWNtqT3ArgMot6HprlmZIeQ+/tQZnCBurUDXYNP44TP2jfNulHdqVteGrtzXVAqRwdSb
         e7Mg==
X-Gm-Message-State: APjAAAVZKMMVQ89beWh67QfDy+YGolM8BcUxc4reVnAkjikGc5TOvwjB
        Kps0qghKaO5SCIs9NgrizBWqsGPc
X-Google-Smtp-Source: APXvYqyYF8EwgrTrmh39fKJq5HxBXHL7O7R8QpY7NiEBPCOSuRP0LnxmxOZi7SY7vBLkpImcMAHuNg==
X-Received: by 2002:a19:844:: with SMTP id 65mr8328474lfi.20.1580583565203;
        Sat, 01 Feb 2020 10:59:25 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id v7sm6472203lfa.10.2020.02.01.10.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2020 10:59:24 -0800 (PST)
Subject: Re: [PATCH v3 1/7] dt-bindings: iio: light: add support for
 Dyna-Image AL3320A
To:     David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org
Cc:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
References: <20200201180024.328700-1-david@ixit.cz>
 <20200201180024.328700-3-david@ixit.cz>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2c026269-079e-01fb-b469-87c6d4f2983e@gmail.com>
Date:   Sat, 1 Feb 2020 21:59:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200201180024.328700-3-david@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

01.02.2020 21:00, David Heidelberg пишет:
> Subject: [PATCH v3 2/7] dt-bindings: iio: light: add support for Dyna-Image
>  AL3010
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit

Looks like something went wrong, ^ this shouldn't be in the patch's body.

> The Dyna-Image AL3010 is a 16-bit digital ambient light sensor which
> provides a multiple gain function with linear response over a dynamic
> range 1216/4863/19452/77806.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---

You should put individual changelog for each patch under the ---, or
just add a cover-letter with global changelog.

>  .../devicetree/bindings/iio/light/al3010.yaml | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/al3010.yaml
...
