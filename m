Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85388209E87
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jun 2020 14:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404648AbgFYMfa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Jun 2020 08:35:30 -0400
Received: from mout.web.de ([217.72.192.78]:42959 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404451AbgFYMf3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 25 Jun 2020 08:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593088497;
        bh=c08GAwWMooTgSMjivBJLW5wuOHOc6rg2GWQRtI4IuVM=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=jyXAkBzfXQ5TMLiwOOOU/b9v7YaGGUlsh2b7C6GiBa2AQtJsNIH+joTtHYSv5c+JX
         nEgWw6rntLoTAp/Yard6WIAgIMv3vNPkagk3N6/TYjQszKgJ3CtqxR9q4ILB8tF9xH
         qTP/3lC8hk02LlGrK/ibCXTytPG8HPrci5D8D/WA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.34.93]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJnrX-1jZN3A0pAH-00KCR5; Thu, 25
 Jun 2020 14:34:57 +0200
Subject: Re: [PATCH v2] iio: magnetometer: ak8974: Fix runtime PM imbalance on
 error in ak8974_probe()
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>, linux-iio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>, Kangjie Lu <kjlu@umn.edu>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <dd84c12f-277d-27e7-3727-4592e530e4ed@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <68225325-ba51-7aab-6fef-6f234f4068d1@web.de>
Date:   Thu, 25 Jun 2020 14:34:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <dd84c12f-277d-27e7-3727-4592e530e4ed@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:QhRKokWt4FyfWowzwqLovxRM/SZ7pFd9wbG5dqH1SpZQro4FvmL
 WifUq+q0h8PfzNlRNErDL/Z8fAJeUkKBd5/NQczCQ+/+Y0TQx+Ou7a0SyRMx7WS26asmY9C
 j1fHshRLNymr5VdMzEnwuO5IYdcd1UOFmd8sYZRtM/BZgFsXzqJQAj0/a1/e5uhoy6R5vqz
 D9vJ7RGAngj5jgQV3dXSA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mGOX4qxT6c0=:eBLwPOLtm2nuEBPVMqt4iq
 yNZyn7Oj/9Z5e4wFB4OWLOlhrEFUutX+FwFfoaJ7SzTizKj3Setof7xD6AgHk8j0ZoxS2O7sg
 QDAU/nDHVQbWQG79R7ghTz6mFz0reWb1iwNsSFsba/WvDuwLuSuMxjMifaULtCD/DL7P4L3lg
 Uf6d1ZwHH+CazAPoVpqJ23DHOZ2P36ZL8UCrL9SAuP84pWklO6AU3z4Qhsr/fHkOngZtYKafS
 otvDLSiyOWZZ/8xQBH39HNY5zIrhrOmLvDuFX339vaMCxtwQai8uoRL31+3Wg/iOeifFhl8RV
 s2Afty3VxoceUPV4eVniVJ+wRQTGSXnDD17i+3UBUMVglQ5GHyi2tgP5jTAOQqgj1y3+ki/Cm
 3xI1QErnghs8+EVKDuSquSAyqyJHKvlDzEqWrADttnfrol7wDVk+KgKUjHt7XCYp6jVnkyVCW
 jvw1uaAHjhoY6Gcecptot98pzcPhr4nRv0VVbkn7hSh68XX2cxRUd45spN0CjGU76Gvx7pb/Q
 Lz1WS2jVkO+2H5nfjM6q91mDkP5D3LvD72uUiQkoHJfP9sKJ9ZGT+NRVO3W1b4RlBJ2bj74LD
 6e+x3TsGg9oFJUGdTeJRMWCE8u572K7MggIRZagQYqnt/WpOFNzQ9yh51wjSalcN5ree5lwmQ
 RMt/EkGednUsZ9IjEkqzojmpkLPUkx859VXKncsVrt0qmcpvjYyqZG87BA0OX9iuFk4i5mZHP
 3ViE//HFGfH9krah59mBks8bHL7XrRYTqciqkkrv5GZjwAj+YMkQxb9sCPYgTmIK4ixIEmhwg
 k7HbFO9ZOd/DNG9s8N/3+GmamvPcdpDouenxa2WOu/lL9xObo1b2ORuNeYqS1TT3Tgt1P7H7e
 ODPYP3AM5nSKhoOnHJK8a4guRleBke2wGxhtTlf+Cc9FdVBHU2pIiuPZCUkdfO4vBqtGhftO2
 ry5T7T7XMUlxwDAXdgEs9b2c1ASSBOluSrTpaoT/tODlUPI+biWNu4i8u7EBxfLpflMAm0Mm7
 C5dbDHTzlSm+ug3JJi+BUQREMNxfrrCI/VzwyQHnjgsK/5dCwJzxZOcwz5hrb/Mk7xnNutAL/
 qa4zPtNjhU1h1sGNuIsSrpGbHw45h/HfsGAdBs40ogra6q0jLRq0Va++oBOD/aaptIYqAVbdf
 2Kfsc0Qh10WhUQ/7NN06buYNaUuv4NEA007MmvjTU+s35kHrVOarffZfTFtUelUCaZFtWw3hg
 my6r7kU3PeLI5+1er
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

https://lkml.org/lkml/2020/6/14/117
https://lore.kernel.org/patchwork/comment/1452516/
https://lore.kernel.org/linux-iio/20200614131116.143bcf92@archlinux/

> There was a lot of fuzz in this one due to other changes to the driver.
> I 'think' it went it cleanly though.

Is it interesting anyhow that you committed a change description
which contained typos (on 2020-06-14 13:08:47 +0100)?
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/drivers/iio/magnetometer/ak8974.c?h=fixes-togreg&id=0187294d227dfc42889e1da8f8ce1e44fc25f147

How were the chances that my patch review comments would be taken
better into account?
https://lore.kernel.org/linux-iio/dd84c12f-277d-27e7-3727-4592e530e4ed@web.de/
https://lkml.org/lkml/2020/5/31/152

Regards,
Markus
