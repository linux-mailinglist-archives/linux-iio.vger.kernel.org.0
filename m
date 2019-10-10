Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB45D31CA
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2019 22:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfJJUDl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Oct 2019 16:03:41 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38775 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfJJUDk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Oct 2019 16:03:40 -0400
Received: by mail-oi1-f193.google.com with SMTP id m16so6037558oic.5;
        Thu, 10 Oct 2019 13:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yaP7dXJTeX24RHvXU2N+fToQZuIg9vgRbc7Fr/BhjY0=;
        b=IU7oUMELs4V1sBIKdelipbr8pg+MLm6Lk/zwRVtiELpnHRC73KLYcjx8R3rWAsNyxh
         ZIRMYMH0rdu6dfCmUSIK3mlteX4D9q84vBvmM4+opiqhU021IWy0nd7mu0ncBqYEHvRY
         O0nNmr6eLxyNjX8k71ztx+ubyrY5xqP227PRt2qHHJ3Q2EnPYvQrDhFJek7pXk0pUSgS
         pUvyCyksBcFEv8md2l9qqrv/pWAsG2PsFvN+yQ0oqGxSs6Lo7TeIk6R3cHhj2635NL8a
         iZRq3ra3UkPRAodAaWwQtVpbXhmS8SgunEXKwY1tWaNWfNWC3kcNUZnjdTbwKt8ygkzi
         lbng==
X-Gm-Message-State: APjAAAWKFt1M/XSf3DNNMPwo/Yb0uD6ifvoeM74cW3iuRc0dTCw67mr5
        DU9mNQbq6b6jLNkHf9NU9A==
X-Google-Smtp-Source: APXvYqxCs9fRPW0jZKSzbbpbbEU8mZZMqdu5IfD9mgEMjcUb4lSmAFw0tktg/XMdznkqTxiRhhHz6Q==
X-Received: by 2002:aca:c457:: with SMTP id u84mr9346527oif.35.1570737819331;
        Thu, 10 Oct 2019 13:03:39 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 109sm2017100otc.52.2019.10.10.13.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 13:03:38 -0700 (PDT)
Date:   Thu, 10 Oct 2019 15:03:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: Add ltc2983 documentation
Message-ID: <20191010200338.GA23834@bogus>
References: <20191004135519.191657-1-nuno.sa@analog.com>
 <20191004135519.191657-2-nuno.sa@analog.com>
 <CAL_Jsq+a7t5ZGf+7=LD2BnGRexJb6wpbBvvSFncgBKV-h3-7MA@mail.gmail.com>
 <27ff86f12b6f0e667c75014dfa0ce8f87087ba4e.camel@analog.com>
 <CAL_JsqKQw-0pCrCaF9TTunM2_icne=1cAUFMnHr544s8A=4X0Q@mail.gmail.com>
 <45a81f890fc32f05209816d66cc7672d90734474.camel@analog.com>
 <4cf4ca811fcc96dec3f07b96165b2ca457b04351.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4cf4ca811fcc96dec3f07b96165b2ca457b04351.camel@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Oct 08, 2019 at 10:22:04AM +0000, Sa, Nuno wrote:
> Hi Rob,
> 
> Somethings that I would like to clarify before sending a v4 since I'm
> having errors and I'm not really sure about the fix I'm using.
> 
> On Tue, 2019-10-08 at 07:45 +0000, Sa, Nuno wrote:
> > 
> > On Mon, 2019-10-07 at 12:46 -0500, Rob Herring wrote:
> > > On Mon, Oct 7, 2019 at 11:17 AM Sa, Nuno <Nuno.Sa@analog.com>
> > > wrote:
> > > > On Mon, 2019-10-07 at 09:45 -0500, Rob Herring wrote:
> > > > > On Fri, Oct 4, 2019 at 8:55 AM Nuno Sá <nuno.sa@analog.com>
> > > > > wrote:
> > > > > > Document the LTC2983 temperature sensor devicetree bindings.
> > > > > > 
> > > > > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>


> > > > > > +          Represents a thermocouple sensor which is
> > > > > > connected
> > > > > > to
> > > > > > one of the device
> > > > > > +          channels.
> > > > > > +
> > > > > > +        properties:
> > > > > > +          adi,sensor-type:
> > > > > > +            description: |
> > > > > > +              Identifies the type of thermocouple connected
> > > > > > to
> > > > > > the
> > > > > > device.
> > > > > > +              1 - Type J Thermocouple
> > > > > > +              2 - Type K Thermocouple
> > > > > > +              3 - Type E Thermocouple
> > > > > > +              4 - Type N Thermocouple
> > > > > > +              5 - Type R Thermocouple
> > > > > > +              6 - Type S Thermocouple
> > > > > > +              7 - Type T Thermocouple
> > > > > > +              8 - Type B Thermocouple
> > > > > > +              9 - Custom Thermocouple
> > > > > > +            allOf:
> > > > > > +              - $ref:
> > > > > > /schemas/types.yaml#/definitions/uint32
> > > > > 
> > > > > You can move the type definition under ".*@([1-9]|1[0-9]|20)$"
> > > > > and
> > > > > then just have the min/max here.
> > > > 
> > > > And how could I add meaning to the values. Could I add all in the
> > > > "parent" node?
> > > 
> > > No, they have to be at the correct level. You can keep the
> > > descriptions here. Just do:
> > > 
> > > adi,sensor-type:
> > >  description: ...
> > >  $ref: /schemas/types.yaml#/definitions/uint32
> > > 
> > > under ".*@([1-9]|1[0-9]|20)$" and drop the 'allOf: [ $ref: ...]'
> > > part.
> > > 
> 
> So, Im doing like:
> 
> ".*@([1-9]|1[0-9]|20)$":
>   type: object
> 
>   properties:
>     reg:
>       description: ...
>       minimum: 1
>       maximum: 20
>    
>     adi,sensor-type:
>       description: ...
>       $ref: /schemas/types.yaml#/definitions/uint32
>   
>   required:
>     - reg
>     - adi,sensor-type
> 
> Then in:
> 
> "^thermocouple@":
>   type: object
>   description: ...
>   
>   properties:
>     adi,sensor-type:
>       description: ...
>       minimum: 1
>       maximum: 9
>    
> This gives me that adi,sensor-type is not a valid schema. Adding allOf
> before min/max fixes it. The same error comes in:

Forget what I said, you're going to need to keep '$ref: 
/schemas/types.yaml#/definitions/uint32' here.

The problem is the meta-schema enforces that a vendor specific property 
(one with a comma) have a type defined and there's not really any way to 
say it already does elsewhere. I don't want to loosen that up globally 
either.

> 
> "^diode@":
> type: object
>   description: ...
>   
>   properties:
>     adi,sensor-type:
>       description: ...
>       const: 28 #adding allOf here also fixes it...

I need to fix the meta-schema to check what's under 'allOf'. :)

> 
> One last issue that I was not seeing before is with the reg property.
> If you recall, you also suggested to have it under ".*@([1-9]|1[0-
> 9]|20)$": and then add the 'minimum: 2' where needed. Doing that now
> also gives me invalid schema:
> 
> "^rtd@":
> type: object
>   description: ...
> 
>   properties:
>     reg:
>       minimum: 2
> 
> Changing to
>     reg:
>       items:
>         minimum: 2
> 
> fixes it but it feels that the first one should work?

The problem is we require both minimum and maximum to be defined. So 
really the second one should fail too. Or we should loosen this 
requirement.

Rob
