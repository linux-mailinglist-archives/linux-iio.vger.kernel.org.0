Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FEA72ADC8
	for <lists+linux-iio@lfdr.de>; Sat, 10 Jun 2023 19:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjFJRea (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Jun 2023 13:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjFJRe3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Jun 2023 13:34:29 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8E63592
        for <linux-iio@vger.kernel.org>; Sat, 10 Jun 2023 10:34:27 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5147e40bbbbso4326447a12.3
        for <linux-iio@vger.kernel.org>; Sat, 10 Jun 2023 10:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686418466; x=1689010466;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KDwuS8ivDaXoqweaWeaVy3Yc3d6wso3xwv2Ixdl0prg=;
        b=x090GQhA4ZtVMlRRaeiyoF+aOZ9q0QqxGwFB2WJ4C6NkF48xzs3saVX7RdJIbeNSUg
         1EsjysURbpivR9Ykn1fQwHgyA/bBbxYmTQcWHupdnq+yw2QBhVZ5Wzckc7rto4jgeVpO
         gooStXFAkOeHT08lVH61GCuNaBIAFkxRL2RRarBYCPBLKcGdPe0CrBuBCfUVUXP+Je0d
         cxA5bmHkmv53AsKHs2/qIS0RxlLDSdu8zw5af+JzdoZp4lvS0oqXyhTzenH9m8BEL7QN
         ejT0ot0x1Ys8nYIdg5CcAFiq67W1gTHRwWoLlecEhlLomuYs4Uc5Q6BmNGZPZWO00cK8
         5spA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686418466; x=1689010466;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KDwuS8ivDaXoqweaWeaVy3Yc3d6wso3xwv2Ixdl0prg=;
        b=jIps4WuxHfqxUAMpC43mUhLEcxe6Y6LGnbpsiFw5+bQg7WJlRXxKhhmgv2LeY1Br19
         LHwJPd4zFLjhh3sdjZYJkVQpWxmAK0IPAHuazoyGKFd/a1wlgOzDENS8Y9Ujnud/uZzp
         qBQCy/z0hJsMUSS3H4qFyfjgwk6YBNUkWmWXxIP7IZhAGSDa8gMi88/DDM08AiU8C3FO
         JowY5jg7nOduEoAL+yG1PmNWsESPXBhpvVQIxVOikWr82XZEf8zAWdNoSeJTcvDVLDyK
         gxOQXQI4DLqWYEYJYur2Mb3VR/RNgyXMHu4ViwxjW5qSmdHaWCh4Ue8fjo5qh2wyeJKi
         7ppQ==
X-Gm-Message-State: AC+VfDyYxqrQ4JOPJFTtmNdQohqLvcCsMmANu2fiERmd+2ReraQ/OE0P
        ojH7VsgNUhoX+HdeD2bl5d9qBQ==
X-Google-Smtp-Source: ACHHUZ4QLwPV4AAHZ1nnSvlebkLfLm6hTSfz7V3skL2ZlTi3k9c5gDLsQvctQyiunCRRfDDndPgBLA==
X-Received: by 2002:a17:906:4786:b0:94f:694e:b953 with SMTP id cw6-20020a170906478600b0094f694eb953mr4758757ejc.59.1686418466379;
        Sat, 10 Jun 2023 10:34:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id g8-20020a170906348800b00977cfa6ff46sm2788903ejb.103.2023.06.10.10.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 10:34:25 -0700 (PDT)
Message-ID: <153ea7d7-25d5-8782-a622-ae512134161c@linaro.org>
Date:   Sat, 10 Jun 2023 19:34:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] dt-bindings: iio: rockchip: Fix 'oneOf' condition
 failed warning
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        heiko@sntech.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, gustavo.padovan@collabora.com,
        serge.broslavsky@collabora.com
References: <20230610143601.173307-1-shreeya.patel@collabora.com>
 <c5243179-9baf-59ce-b979-c596dcf6692b@linaro.org>
 <20230610171142.dsezim4gcxr2b65u@mercury.elektranox.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230610171142.dsezim4gcxr2b65u@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/06/2023 19:11, Sebastian Reichel wrote:
> Hi,
> 
> On Sat, Jun 10, 2023 at 06:30:57PM +0200, Krzysztof Kozlowski wrote:
>> On 10/06/2023 16:36, Shreeya Patel wrote:
>>> rk3588-saradc isn't compatible with the rk3399-saradc variant,
>>> hence, fix the following dtbs_check warning for 'oneOf' condition
>>> failure.
>>
>> Are you sure it isn't compatible? According to your driver it is and
>> this change is not enough.
> 
> The driver changes are still in the iio testing branch and not yet
> in linux-next. RK3588 ADC is not compatible with previous
> generations. It's trivial to see in Shreeya's driver patch:
> 
> https://lore.kernel.org/all/20230603185340.13838-3-shreeya.patel@collabora.com/

I was checking the next. It's fine then.

Best regards,
Krzysztof

