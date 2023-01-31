Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E1C6832F2
	for <lists+linux-iio@lfdr.de>; Tue, 31 Jan 2023 17:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjAaQo3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Jan 2023 11:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjAaQo2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2023 11:44:28 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496EC561B1
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 08:44:23 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso6063252wms.5
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 08:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VACkZgLatYW5HQqyGfJo2+gfSctgdtIk3yDVLriuhMI=;
        b=jDtpgJul1DbH534h4IWyZpa6j2ujhnXHivY/FjkiRkeUp+2PLAmwOMmUeOpPyKFfXH
         GI1p+sCOUY8GVbnvrT84y+yQaPOw7MUCztDIfZDjrq4c7zaOxouC8HGB0qGcPMqIgptV
         MuwHC9TRT8MjGwC60YZbhcDUrlApFFhhEyCRw9euY8WjB5BYmKspmWLu26c6kGccrIn+
         6efTRq4wHthltHHEDg6GqiBrTqplZH4zECBtDyxQrm0+UBD3ptPLmm5eiPuM2nb/cRrB
         xUV5W32S4DUryzOu0pKgPU0bli542Doqs+4HqpdDS55xGdfduP9FlXhNj7bh1pm6JeXV
         U2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VACkZgLatYW5HQqyGfJo2+gfSctgdtIk3yDVLriuhMI=;
        b=bw6z+6dkxvQHTNrrstuIP3oJMSAsRG2RTPEXfFOkj+Tm9VqZe3jBFIbCSFoLUJwWY4
         OIhnKS3q7zO1ADiGjMUR5HycFmwKUJrvdrDNx5oUl7kfavgIXUZ7qi3AcH6mF9t60UOl
         x6zCRuMdXHM0CtSOKglxU3SgxNNjJ6aehPdw17CuNwO5qZVqASyUu9Cyc4tx5QuGYpsR
         RX2NVauqqaUPv7qdshQx0o5TYTysqE8pcslP2B8dWtosBHKUJPPjYtUAsKuTrFLEY7dM
         Kl/marNVlLJQft712cLQPCDO6dckaIV1oAe+O3ZRDOl8Xg0m1EPo9axG6KnW12inRGcD
         1+4Q==
X-Gm-Message-State: AO0yUKVaJPEitNPakfW+l68Z04WVnOGF5jxucghUMyYSaUHFrPCqzL+U
        UCxIINPb7II4a+vBctF48GBiNQ==
X-Google-Smtp-Source: AK7set/ur7S6CdxKnb7cMV+i2Tl9KgmWwXAz1NW3CfurIE87CpN2UzlaovzvtcsXKy3o97Lc7aXONg==
X-Received: by 2002:a05:600c:4e07:b0:3db:30c3:ed83 with SMTP id b7-20020a05600c4e0700b003db30c3ed83mr4407987wmq.28.1675183461849;
        Tue, 31 Jan 2023 08:44:21 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c248300b003db0ad636d1sm9436348wms.28.2023.01.31.08.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 08:44:21 -0800 (PST)
Message-ID: <04ac07ef-ee4b-abb8-9fb2-114e3a646a2f@linaro.org>
Date:   Tue, 31 Jan 2023 17:44:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 2/5] dt-bindings: mfd: Add ADI MAX77541/MAX77540
Content-Language: en-US
To:     "Sahin, Okan" <Okan.Sahin@analog.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20230118063822.14521-1-okan.sahin@analog.com>
 <20230118063822.14521-3-okan.sahin@analog.com>
 <c4433cba-ce35-e5d3-f04b-ba8f9f501732@linaro.org>
 <MN2PR03MB51685B56D49CBB590BBE6B7EE7D09@MN2PR03MB5168.namprd03.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <MN2PR03MB51685B56D49CBB590BBE6B7EE7D09@MN2PR03MB5168.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 31/01/2023 13:02, Sahin, Okan wrote:
>>> +  regulators:
>>> +    $ref: /schemas/regulator/adi,max77541-regulator.yaml#
>>
>> No improvements regarding bisectability - this patch fails. If you tested this patch,
>> you would see it.
>>
>> Instead of ignoring comments, either implement them or ask for clarification.
>>
>>
> Sorry for misunderstanding, I checked patchset as a whole not one by one this is why I did not get failure after "make dt_binding_check " . Right now, I understand why you are saying this patch fails, but what is your suggestion?  what is the correct order for this patchset? I sent adi,max77541-regulator.yaml in path 4/5. In the light of discussion, should I remove all the parts related to regulator in patch 2/5, then add adi,max77541-regulator.yaml and update adi,max77541.yaml in patch 4/5? or should I add new patch to update adi,max77541.yaml?

Regulator binding patch should be first in the series (bindings are
before usage), then the MFD binding should come. Your cover letter
should clearly at the top mention the dependency. You can also mention
dependency in MFD patch after ---, because many of us do not really read
cover letters...


Best regards,
Krzysztof

