Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E61D285300
	for <lists+linux-iio@lfdr.de>; Tue,  6 Oct 2020 22:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgJFUUJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Oct 2020 16:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgJFUUJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 6 Oct 2020 16:20:09 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DE3A20866;
        Tue,  6 Oct 2020 20:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602015608;
        bh=b8ArT6LXHlWkIib+3EQqlUASnv1A1oBGpgxljs1RNG0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DbjE6eEscYH7C65shkggEFbur/JA/O4DpEi7j2srOSD01l6LtReG3Rs7IvcCenpcj
         EGL76xFjb80TbAJBzNvZe2uceibIo9PRrVo8Zx52N12IOaaQRh2s2cxdNWBi6otOyV
         UcgJsvSwhP1DdsnXlA7ngJabBM5vUAsOQXzFj6bg=
Received: by mail-oi1-f178.google.com with SMTP id z26so13998945oih.12;
        Tue, 06 Oct 2020 13:20:08 -0700 (PDT)
X-Gm-Message-State: AOAM532srC1+ApuCRbL3okaUQkJTsXR40i15qn/povde31RgJ3+4ZWeT
        pvqs8C1a566OFmVFMi7UkfsegPI8uWwPMLVx8A==
X-Google-Smtp-Source: ABdhPJzHJEPwmpg9bbDxU3qoFGFWIAb2vl21r0VCYUJowQgOaa4/9Q5HgWyQuwTRPfcCQDejT0UefoyDxFnCUSs0NQE=
X-Received: by 2002:a54:4f89:: with SMTP id g9mr16799oiy.106.1602015607574;
 Tue, 06 Oct 2020 13:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <b665f17d-0029-b51b-ac09-597f7b26d77b@metafoo.de>
In-Reply-To: <b665f17d-0029-b51b-ac09-597f7b26d77b@metafoo.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 6 Oct 2020 15:19:56 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK=VnTUMztHvhNaz6xn3wDsUD4jyYoRYvNEYZGTagKDow@mail.gmail.com>
Message-ID: <CAL_JsqK=VnTUMztHvhNaz6xn3wDsUD4jyYoRYvNEYZGTagKDow@mail.gmail.com>
Subject: Re: yaml schema and sub-nodes with vendor prefixes
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Sep 21, 2020 at 5:53 AM Lars-Peter Clausen <lars@metafoo.de> wrote:
>
> Hi,
>
> I'm trying to convert Xilinx XADC devicetree bindings[1] description to
> yaml format. And I'm running into issue with describing a sub-node with
> a vendor prefix.
>
> A typical devicetree entry for the XADC looks like
>
>      xadc@43200000 {
>          compatible = "xlnx,axi-xadc-1.00.a";
>
>          xlnx,channels {
>              #address-cells = <1>;
>              #size-cells = <0>;
>              channel@0 {
>                  reg = <0>;
>                  xlnx,bipolar;
>              };
>          };
>      };
>
> So there is the 'xlnx,channels' sub-node which contains a set of other
> nodes which represent the individual channels.
>
> The way I'm trying to describe it in the yaml file is like
>
>   xlnx,channels:
>      description: Node containing all the channel nodes
>      type: object
>      properties:
>        '#address-cells':
>           const: 1
>        '#size-cells':
>           const: 0
>
>      patternProperties:
>        "^channel@([0-9]|1[0-6])$":
>          type: object
>          properties:
>            reg:
>              description: ...
>            xlnx,bipolar:
>              description: If set the channel is used in bipolar mode.
>              type: boolean
>          required:
>            - reg
>          additionalProperties: false
>
>      required:
>        - '#address-cells'
>        - '#size-cells'
>      additionalProperties: false
>
> This now fails validation, presumably because there is no match in
> meta-schemas/vendor-props.yaml. If I drop the vendor prefix from the
> property name validation passes. I can also make validation pass by
> adding an arbitrary $ref property, but there is no 'node' type in
> types.yaml.
>
> What's the best way to describe a node with a vendor prefix?

Don't. Update the node name. Given there's only 1 child node, the
driver shouldn't really need to care what it called.

Rob
