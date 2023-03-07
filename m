Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2696AEA5F
	for <lists+linux-iio@lfdr.de>; Tue,  7 Mar 2023 18:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjCGRdO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Mar 2023 12:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjCGRcu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Mar 2023 12:32:50 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D7646146;
        Tue,  7 Mar 2023 09:28:27 -0800 (PST)
Received: from [192.168.1.141] ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Ma1D8-1q3AgD15cq-00VyvW; Tue, 07 Mar 2023 18:27:57 +0100
Message-ID: <9c2d0ca3-660e-72d2-d158-5c921cd9d607@i2se.com>
Date:   Tue, 7 Mar 2023 18:27:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 4/8] dt-bindings: iio: st-sensors: Add IIS328DQ
 accelerometer
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     linux-imx@nxp.com, Li Yang <leoyang.li@nxp.com>,
        Denis Ciocca <denis.ciocca@st.com>, soc@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@chargebyte.com>
References: <20230306172249.74003-1-stefan.wahren@i2se.com>
 <20230306172249.74003-5-stefan.wahren@i2se.com>
 <633b1e27-d148-62d2-ef83-2d0da432c0a7@linaro.org>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <633b1e27-d148-62d2-ef83-2d0da432c0a7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:O/1gCxxJ4Mw2c/1cIrf968QzB5NcAlRw7etSNcRG5kKSxI8cG+j
 JmTbjPMIG3c+z2pw6/pb5b9VSARGq5Zt88DTdZtvbYX4jK+4AKsTwsVa3O/PB4ugfPy/EOh
 SAN1xIukGhsOhVgK9AJewTBz0SG+yfF0uCpxLbcwhpJPPIdBFq5tTAYkFyuVtiekrYxCGqh
 rxnkXEU0wokKSLutyBkDA==
UI-OutboundReport: notjunk:1;M01:P0:qIJq0AFaHo4=;vgLd/xuL9mm0K+pmb6vrKBNF7kd
 prKnd7qZcxOwDaKJJ+iC1XQHH7EO59KzsO9akK5h1/uj6Hkt4HrIen7jnS1Yn8IcA3EZJFn54
 FNsoDRyN47wBuK22WCXxlEocqvMWZfr7kbIKUUKK0ZnKN4TbLes9RM10DN3gnk7sTrD7Smpqm
 XgNY1cDB2pkGILR/x28ZuwROiZ8dtyJobq+JtXGojZU71FM39MUYsWdiXCzy7MPBwYHzqSfn9
 3ZqzCxkXc105LyN7WMsnvt7StBDB6KftgCckTOIZLNGxIWjNpHJwCJ5Ynlum6uwkw9L4OtSYf
 woVwkjFHjO0hbrOnczsKkI6eM2hXxn5kt/rGSflFnsQ+dLHuZ+l/R1IRcyM+R02ZU33R6lEzC
 zbmR2D5j65Ik6Gu/NxqCwfBEFnP13O3Id7qWUZMyh92LKZ+DU2QWpgsn0tn4o+y6NuAmQbZTb
 wW4ZY2jRcmSEUM/mnvf9jVR5spY44f/LS+iwplopGHHgocHMuoOpyZZVwt+mseMtUWIfTuy9x
 uCo0euC4GyzZpJCe1Fy3QAwqrn9XMwMWw3Dz+dCuZs0wBS40AKfoqIJ26O8ozbkSPu8ZuIMe0
 inns/O9BhtKuLog30TstP8kORE9rS3j6VtYfci36bx8nCKjf/f2GoAKzXguMgokIpubuKMgl1
 9lQm7dsi6LvfDVOWjdi+jSk+1v3m2zRHTB6SXhzafg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Krzysztof,

Am 07.03.23 um 09:23 schrieb Krzysztof Kozlowski:
> On 06/03/2023 18:22, Stefan Wahren wrote:
>> From: Stefan Wahren <stefan.wahren@chargebyte.com>
>>
>> The ST IIS328DQ is an accelerometer sensor compatible with
>> the existing ST sensor binding.
> If it is compatible with existing binding, then make it compatible.
> Although your driver change suggests it is not compatible...
since the policy is to make the compatible so specific as possible, i 
will fix the wording here.
>
> Best regards,
> Krzysztof
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
