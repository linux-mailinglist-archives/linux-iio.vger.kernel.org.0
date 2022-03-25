Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195F54E7C77
	for <lists+linux-iio@lfdr.de>; Sat, 26 Mar 2022 01:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbiCYWDY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Mar 2022 18:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbiCYWDX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Mar 2022 18:03:23 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBC656229
        for <linux-iio@vger.kernel.org>; Fri, 25 Mar 2022 15:01:46 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id 9so7311119iou.5
        for <linux-iio@vger.kernel.org>; Fri, 25 Mar 2022 15:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aFYCnBGRhXrqb23iFm/MXmr7Vdc8c4isuA7+pg5zAdM=;
        b=Z8TngSKCoEjxxlMXC+sAhqM8ryr1njebeCQbfXT4RsnYIVmKqL1oUwWqPVh7xnWDdf
         yFrS6EbaJz2T+2MBmstTIQnhye6OPsBN3vYykerAXiJ751qc3pjHTgm/mo4soV3mWTx2
         TGlhRC7p1QcJjxDmcAZBMJoidu2uaoPJp+e+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aFYCnBGRhXrqb23iFm/MXmr7Vdc8c4isuA7+pg5zAdM=;
        b=irSuUcL10DyNZf/YLIuG3ZR+pdFR5ATE1U7S2jxJPRnlydjcGyCaq8OgA8iNd4x7Jy
         +Ie0DgxvxE97WGc4U6SkdLvLaiDKxKdFntN2lW3+eni/r7WFhfaFcERfQU4YIYa5lvFL
         tPASYx8vow8F2hL8+Ros+45fpnNN2MzuNO+x8qPn5AmAoF8Zg1+8d5S/DkqZeBfObtNz
         B/DWf69nMhKXN3kOnLZ6Tydq/9O+/ZW5eb5OEvEFlM/XYlFvysGatBQ3PlO9OCy/qtJz
         sYuvr4CIeUZE1MgeJKKMgkzzu70LT5LBBSsPsZC3/pSRFYdqOBnKUzysi+ifX1Kf+bGk
         tHIA==
X-Gm-Message-State: AOAM532eqMrs53I1OAuBUNLKtHCbW7ib/em6OavdtIDV9yFsk1AFUNB9
        pppFXH1yCrBaIVYsbStK/AyjOE8WQjrSF+ETkAiGdw==
X-Google-Smtp-Source: ABdhPJzbUiqLeAmyH772kZm8hOoiPDziS8x5xMz9xNShJX12xvwYbsTMdYzOMpEfN2qEX4IQSBu4Av1eLEswTH9pMEo=
X-Received: by 2002:a5d:9481:0:b0:649:db3d:5141 with SMTP id
 v1-20020a5d9481000000b00649db3d5141mr576519ioj.63.1648245705965; Fri, 25 Mar
 2022 15:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220322062504.1019504-1-gwendal@chromium.org>
 <20220322062504.1019504-4-gwendal@chromium.org> <CAE-0n53foJE6hy6SebN8FCErBTMUYGpjekOrinJ0e1OfeSa--A@mail.gmail.com>
In-Reply-To: <CAE-0n53foJE6hy6SebN8FCErBTMUYGpjekOrinJ0e1OfeSa--A@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Fri, 25 Mar 2022 15:01:35 -0700
Message-ID: <CAPUE2uu4Rt3HNSZZN3Vmm8cASacpB_5tnKrK28AyD+jR730mGA@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] dt-bindings: iio: sx9324: Add precharge resistor setting
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     jic23@kernel.org, robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 21, 2022 at 11:51 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Gwendal Grignou (2022-03-21 23:24:59)
> > Allow configure the resistance used during precharge.
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > ---
> > Changes since v1:
> > - Suffix field with kOhms unit.
> >
> >  .../bindings/iio/proximity/semtech,sx9324.yaml           | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> > index b8a6ee16854ff..8fbea71823e76 100644
> > --- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> > +++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> > @@ -126,6 +126,14 @@ properties:
> >        UINT_MAX (4294967295) represents infinite. Other values
> >        represent 1-1/N.
> >
> > +  semtech,input-precharge-resistor-kohms:
>
> What didn't work about using ohms? I think the goal was to use a
> standard unit and then scale it up in the binding and in the driver so
> that we didn't have to have a $ref below.
You're right, it is better as it is defined in
dtschema/schemas/property-units.yaml from
https://github.com/devicetree-org/dt-schema.git
I used kOhms as it already used in the device tree (by
bindings/regulator/qcom-labibb-regulator.yaml), but in retrospect,
this example should not be followed.
A v3 is coming soon.

Gwendal.

>
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 4
> > +    description:
> > +      Pre-charge input resistance in kOhm.
> > +    minimum: 0
> > +    maximum: 30
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -157,5 +165,6 @@ examples:
> >          semtech,ph01-proxraw-strength = <2>;
> >          semtech,ph23-proxraw-strength = <2>;
> >          semtech,avg-pos-strength = <64>;
> > +        semtech,input-precharge-resistor-kohms = <2>;
> >        };
> >      };
> > --
> > 2.35.1.894.gb6a874cedc-goog
> >
