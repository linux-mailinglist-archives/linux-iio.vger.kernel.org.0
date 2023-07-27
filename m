Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606A07650D4
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jul 2023 12:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbjG0KUq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Jul 2023 06:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbjG0KUp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Jul 2023 06:20:45 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846E9170D
        for <linux-iio@vger.kernel.org>; Thu, 27 Jul 2023 03:20:43 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52256241c66so1582011a12.1
        for <linux-iio@vger.kernel.org>; Thu, 27 Jul 2023 03:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690453242; x=1691058042;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NAhN5UZMwKqXYijGqauqa7dfSLJbu7yyHS9/554Fohs=;
        b=fcLnQwhALWJPAevj2vqLyYT3SatnE2jQqbYGltQJqcVCJni1X/FrfV5IDxMeeEdIJO
         pzPTIqOmfVIjAc2xKvFtDS/i7vDmVls4vEXvu2HSrKTdSgjNOsUK61iRtv1IDoKTzmG/
         g5SYlMvqlK4tuWGXgY4AEOFH4hIHEEVTvu22ahqounC3Wprbe5wOvWTd/5tv7Nf5B6ts
         AtYab8+4jYE+m49XScdXVgqlbAyEZGR+kJJTeGRuGzvmcgwF/KP4GzZL3EBkDwCJhOhP
         Ja0j6ejRPFB4AfrGphAMiE2JvA5XJnoQeeU+61N+GRRUFQsuO+AuTRowm3XXVMBDroE2
         W5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690453242; x=1691058042;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NAhN5UZMwKqXYijGqauqa7dfSLJbu7yyHS9/554Fohs=;
        b=L6VWycQzX4ZTyoWzsgJQDGq+Ix5/Tbquh1l2RtFTlkFwfGh/2J8HmZ7K5MuwqhrPUG
         L50yf8HeaKCuoiLtSgrSzzwwD70IPgHFbB8+ajybFpVR6nXCqCBChOxTn9KmKOU9BeHf
         YofGv0BgUemU2uMpKfV0hvuVbdpAI5IzsDCLDHTy7X01hk817JREfiyIYUGVIbZRZj0k
         oZUF1QMorokFTUP8nFJ+jxhQ45PYeTSCbf1PB/uXVbqiwzdt9XWRbdU2XjHmvGw5pPYB
         HFuY7NcSua2UViJSyNEwPFBza9sC/FzdmQ+OB7QvmUCaxRzbvQhjCpbRTj0lG+KdPTwV
         Wgww==
X-Gm-Message-State: ABy/qLak/+Vyr+OFjnxRu8W8QY3PhFE+PY8OD+uKchI0deq7eiAxIraj
        PIn2AHA1sTrJK0pFDvfApvg1mMEDuKR7sGLkCCU=
X-Google-Smtp-Source: APBJJlFHzU/liDW4INHacXfd98M62dTAxLA+evBaQfoqNtW8BtxN/Szyqoizdp1a97uMgfJ3pe7W7A==
X-Received: by 2002:a05:6402:5188:b0:522:28b9:e84c with SMTP id q8-20020a056402518800b0052228b9e84cmr1694048edd.21.1690453242000;
        Thu, 27 Jul 2023 03:20:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id m4-20020a056402050400b0051e22660835sm488191edv.46.2023.07.27.03.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 03:20:41 -0700 (PDT)
Message-ID: <064951c6-2ddb-1488-1d4a-694e927e3215@linaro.org>
Date:   Thu, 27 Jul 2023 12:20:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: mcp3911: add support for the
 whole MCP39xx family
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230727101318.2764379-1-marcus.folkesson@gmail.com>
 <3c69b206-a9f0-c8f3-70a1-3994e056140b@linaro.org>
In-Reply-To: <3c69b206-a9f0-c8f3-70a1-3994e056140b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 27/07/2023 12:18, Krzysztof Kozlowski wrote:
> On 27/07/2023 12:13, Marcus Folkesson wrote:
>> Microchip does have many similar chips, add those to the compatible
>> string as the driver support is extended.
>>
>> The new supported chips are:
>>   - microchip,mcp3910
>>   - microchip,mcp3912
>>   - microchip,mcp3913
>>   - microchip,mcp3914
>>   - microchip,mcp3918
>>   - microchip,mcp3919
>>
>> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>> ---
>>  .../devicetree/bindings/iio/adc/microchip,mcp3911.yaml      | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
>> index f7b3fde4115a..06951ec5f5da 100644
>> --- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
>> +++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
>> @@ -18,7 +18,13 @@ description: |
>>  properties:
>>    compatible:
>>      enum:
>> +      - microchip,mcp3910
>>        - microchip,mcp3911
>> +      - microchip,mcp3912
>> +      - microchip,mcp3913
>> +      - microchip,mcp3914
>> +      - microchip,mcp3918
>> +      - microchip,mcp3919
> 
> Your driver suggests that they are all compatible, so maybe just use one
> as fallback?

Oh, wait, you did put match data, just not in OF, but SPI. It's fine then:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

