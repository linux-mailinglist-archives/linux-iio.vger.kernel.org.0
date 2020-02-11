Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8783B158B10
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2020 09:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbgBKIJt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Feb 2020 03:09:49 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37587 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbgBKIJt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Feb 2020 03:09:49 -0500
Received: by mail-ed1-f67.google.com with SMTP id cy15so3617334edb.4;
        Tue, 11 Feb 2020 00:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qP9vlolHUpvniIGESvHc/dzVKJmtPa4m5oDkf6etjNQ=;
        b=HeBfqybSM8Fe1U/+lGw3hiHOpBCTo7JNmoHibRkVTyZ89oN30pZ9Aqagn1aZ+sYqdP
         xxDoQDkkE2LvDXk8lxTlt7NMc3rqqcUBYGhJZQsfTIcJJxZmE5K+OMFp7rX6IYYsLPBy
         q5VnCmuNGOVJEWR0kDWNgS28ugEUwCB4IaIMtk/4hgKsZuHhvuBa5T17C0geS3hEsblh
         h+PFmTAfL1XjLChBy7HoToK+haEO97FxVBJlUt5e2FMIYKFP6mN3JGNJsz8X8h91XSPx
         iZN7ls6GawhAnEqQQmw/Bx6uWo3dUeLk5YTSlzckwFiByvhasFq8mZesBpRGNBfCgqUv
         p/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=qP9vlolHUpvniIGESvHc/dzVKJmtPa4m5oDkf6etjNQ=;
        b=TkqPi7TjaYMcchLnaEsJ4wSfnCtHNa9C8pFu7+mwAdp1WjRpX5oPoyveguK0BXWzsB
         xjHbIAMtR4ep7seifLcHG/SgXSHIbY+14nC2Ncl3i60E9oqGXE7j/bbmS07XkXbBMKw4
         rbly8uFDpKYo2BkpEI0XkMwGDFJ2WX0W2Wgtj2sD6V41Y7Nxjz1A2U8FFKq8JHui7YdI
         mQy36KKQ5AY21FHTXIe69anZTBqfIQb55TPhzUkboL2TvBWGNaxDt30IJ+a5/YW18oIQ
         6Q1QAhGgx6Mk/9bGhrJHhsnK5aCJsmlBrtsM61P2wF4gNTO24Z+qT8eppgyDIIOZav66
         7sfg==
X-Gm-Message-State: APjAAAUS6pyCODJlO8K/Qln+GXa56O3C12IVelgJHD77lDwWnaor6yEF
        FTkQWXMqQ1fF8pucaGDPkwgj3ZPBgAs=
X-Google-Smtp-Source: APXvYqz9BJSZ/3ks3lGjBuChC1lSDcPAteW1tLkGId0IKFa+ZcG1XKKkAyfpZZPlUm3mjWSH8KamlQ==
X-Received: by 2002:a17:906:a454:: with SMTP id cb20mr5087711ejb.205.1581408586719;
        Tue, 11 Feb 2020 00:09:46 -0800 (PST)
Received: from [100.84.57.50] ([213.55.220.235])
        by smtp.googlemail.com with ESMTPSA id cb20sm171727edb.1.2020.02.11.00.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2020 00:09:46 -0800 (PST)
Subject: Re: [PATCH] RFT: iio: gp2ap002: Replace LUT with math
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Bakker <xc-racer2@live.ca>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linux Input <linux-input@vger.kernel.org>
References: <20200208123359.396-1-linus.walleij@linaro.org>
 <74ab4b7b-eae2-0c6f-bb4a-eabbd3b4d042@gmail.com>
 <CACRpkdau3ei4OXcpucctxKqb7baHsMf8a0Q6sQ4P=gOf=bxQ5A@mail.gmail.com>
 <395b3e38-cea4-9376-1544-f1ef85abf171@gmail.com>
 <BYAPR10MB34797AABF2536F03BC3B4065A3190@BYAPR10MB3479.namprd10.prod.outlook.com>
 <9797aa15-eed1-932c-3cd6-64d7ccbf9d5e@gmail.com>
 <CACRpkdb38q0iDa+Y18bE82haoSTXzbuORjer=g9yMtsw4COuJA@mail.gmail.com>
From:   Gregor Riepl <onitake@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=onitake@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFRqKQQBEACvTLgUh15kgWIDo7+YoE4g5Nf9eZb9U3tKw9gDLbkhn8t5gdMWMXrV2sSM
 QyJhkzEWdCY9CMgEhw4kLjGK1jUaH6VtSq++J5+WqgJ2yfdruBClkKC8pdqtQzgo6HvFf5+b
 mm1orwDu66KkgunMfwFlVy4XtXcV0cxpq9xCfNd+Z7EV6XHDlPbJa/9Z1Jvo5/sh6sJKzLR2
 JOHi2MqpTh1Z2nUv6jmo4qiO4WFnkL0PGAmiaEOUplLDs4ImXEfhvSS3bodZKaIFMMS4/kCd
 6I+VfICJARN6DAxLaOrhOveG2AaYxH7syBuBdf/JfFFEHswudxJYqXUKc45okVtqkYAELiF/
 WiCHJ81KRQV9lKBzTdeA/y7CdH+7zQqw/raLtZeDw0FXV7U0Tb+Bo22WeCHy9/tvAOWaoBOH
 4UfayffBBCzGGcot+1rLMSUnl8HkmpFQqUU8G8iUPu7Q4eecUPkIw90BApNL/aSCSFa8wPtS
 vTvDMgXfM0chLplwlmCFtkjohTJiAU9QudU5SAB0x1EMTXADCAW3LlEN40OhiSMApVxBGJQp
 cIroWAU6g+odEUuZjOUEo3Cf5moq54dfu6N32BSV0tJjOhsP3UEfc4MddRrmdWrxDACmAm01
 Lia80xUrC9P1bVmZrKAyMVI59VA8kIds8mz6EwURvu4s3bKK+QARAQABtChHcmVnb3IgUmll
 cGwgKE90YWt1KSA8b25pdGFrZUBnbWFpbC5jb20+iQJUBBMBCgA+AhsDBQsJCAcDBRUKCQgL
 BRYCAwEAAh4BAheAFiEEPkOFdHER5+Q/FLrcsjUP+dUbWacFAl2u+9QFCQsmBkwACgkQsjUP
 +dUbWaeqAw/5AVAn6e1PoAmLCTT3WwiiuN2ofIXxhR+3LUsisyBN6O1+R4DqrGAKqvQ9ZBf2
 JWBbvVnl41Fm2RmJCWe0+iBpQx5i8iQBZR/yt/ClAmGPTHuvAZ8O3f2ZIKt2+Aisa9rSTh9O
 6kHf0cBVrjFeumlyKB2zmPEgdSJH7//8nPoxDq9+Y6Les4p3G9qgc8WHzmWpKVo3PhE1KBEo
 PaZZiNTVh/fKj7pNplGw05pM8SHdbDEhi8mVb0s235i+9ff0TlC0LkN+HLT+SLzFCws35ZJr
 oQzlHmsmXKMmidO9GSoEG+ASuVzC/HrcxNt1MlI7lIi07KkdxUHsi9bhW3oXCW21iNQYw6G3
 WF1GTepHIAL94b91jhY+Dlv9rDGA7DeZAP5hTsdYshYqNTAvhMncAS6pqpC29/xFPRByHhke
 GsD5JJUnjcS+lIAjzjuI6HmejZRxAGcwn4WAXE4Y0obbpb+CPM9BJsK5WWeJ/U3fhGkOy1X+
 ArtpgIMPRpDLXstq+CBXSA7AGbBXmaAK7BMMyf3w0QAULVZ4+kQq4G23i5PobHn4c21PDXBT
 B8emT6BDqYGLmnCCpMlwtU1F4nA5NjpZDYqb+QiTJuOn2ITF4Z5Btqg8o6cUugo2ni7okrGe
 ire6u0m0ymZX8BRFy+c+avsTExB9Y+ebSos+/M185JFNIee5Ag0EVGopBAEQAL3dZzXKwjh/
 quggj9TUBKrNLo63gIHHvooIQ5FxJcWYcY1+zQfQA/MXM+SPI/3tGpH/Ro09Ioq1RV/R+5EO
 Ur7uk6FDpfPgpCwzQoTqaMI2NShYZNCC5ONm/KoKrw318YH8D/CDaH8xrP694iVNuuqmYSGi
 i+7/0QnbVV5A6+UkhWd+aHYKMJ8FGG/+pEiesKHVzKrVWXX6i6vYqD7RDRqCAC+VLSoGWosH
 FLw4Hqd0OaE/CoRHl5OQW+3bpam3ea5+akYot81YPBqJKA2PWicGmZyoH2LrwugY4L/vuG5f
 v6BC3NcM1Cj2abe2kRitDckXrhdoOartPVHIgnCUhGqsSO0SiKYmYx5jTyJ9yvxZxbNUKGdB
 V9fmgIQhsDRITZSgzVkK6K7OVRVrotCL7NUO9JHFSbfnsDZFXM6GN3J6fLckNGEFBl+X3hlx
 MDSvtYdyefJsitlIoLCMz04XLyqStwwSX3HBvRA7qO+uX+/5G/BOgafe17j5RQ/6fcTPYOaL
 YCffJZ4N9znyGPiLCLL/0w0/hSCHEgX2m/Iq1sI6lG5K4NGlr/K/w2HE8XNLI2j0Dkt0tP/6
 VtwUtm+3Ch9hr7jqlkEl6MVhOeLYvtHtT6bjtXcLcmH7lkjqEouEteRTVLjTBA3N7zYN+eg5
 QY76YGH6vDJIzau2noYxByYLABEBAAGJAjwEGAEKACYCGwwWIQQ+Q4V0cRHn5D8UutyyNQ/5
 1RtZpwUCXa78AAUJCyYGfAAKCRCyNQ/51RtZp4zsD/sHuhFT4RYT47jPRzaxWgCTz/pZft78
 k8tRyX2n5s2cLSmT6HnAviCZh4baXP09HlHneKeMvsY1+dhqihJPIbtmnEoZXdPlF61CaI06
 xKC+zN4M9c28TS4M9pCbMNKAmHY30UiIXfPvq2801eIv6eZXi2yDg2KWoO4Hl1ZAlduLxlKj
 R/1+7iHK69uj1j/oGY6cNWaPX9mldLSb3ik+3c4U527fpzUdmOFC0AqpBI+tLucZ+f+nVRO9
 jGothiBQdmv7DFPl0IH9vCHpiBa7zawY2VwMwmZSmAcPsnL64zJ+BZUHLY72oKE1ju3a1qz7
 Qg+Edu1u/6O42J8rnUtgnzzO1Un6S2md7KQX4XIv5m7KUitNZ2wN1d4izGOhLT8MWv+KKg3U
 anM93AOBO4+atvDdzLuminj117zz2d66NhJQd98UhWND0+BW2G++l7HXdvBAAxb3od/6ukFJ
 +FCYtQpuwZsu9NW1h1UUWsQY/S21cd0jhNWgZI5H23baMU2zUcT+HDxqH0NBu6PDcbeKcRnw
 aN38VJxYshOSap/KQAKkqXC8mYHC9jTFby9gD9M2E0u6Z/oaGS6YvUmBaGkbFz8loHHjsTAB
 LSz/Xp3Qd7MD3P8qytVIxNhzrPfAU07vn1YBQtvIngQ38AQCt8pQbo++r458LUmNN1x2ydXU
 WFSiKQ==
Message-ID: <1777a0f2-08bb-3629-7c85-074819ffa5a0@gmail.com>
Date:   Tue, 11 Feb 2020 09:09:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdb38q0iDa+Y18bE82haoSTXzbuORjer=g9yMtsw4COuJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


> This looks VERY good!
> 
> Can you provide a patch against upstream (Jonathan's tree)
> or do you want me to pick the method and send a patch (I can
> add in your Signed-off-by in that case, if you approve).

I think it will be easier if you just pick the method.

You have my Signed-off.
